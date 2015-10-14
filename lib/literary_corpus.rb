
class LiteraryCorpus
  # URI for sections
  # https://en.wikiquote.org/w/api.php?action=parse&format=json&prop=sections&page=Neil_Gaiman
  # https://en.wikiquote.org/w/api.php?action=parse&format=json&page=Neil_Gaiman&prop=text&section=2&disableeditsection=
  # API sandbox link
  # https://en.wikipedia.org/wiki/Special:ApiSandbox

  LIT_BASE_URI = "https://en.wikiquote.org/w/api.php?"

  def initialize
    @path = "literary_corpus.txt"
    @backup = "literary_corpus.bak"
  end


  def build (author)
    get_lit (author)
    clean_lit
  end

  private

  # ____ LIT METHODS ____ #

  # Collect Wikiquote sections
  def collect_random_sections (author)

    response = HTTParty.get("https://en.wikiquote.org/w/api.php?action=parse&format=json&prop=sections&page=#{author}")

    sections = response["parse"]["sections"]

    quote_indices = []

    sections.each do |section|
      if section["number"].to_f < 2
        quote_indices << section["index"]
      end
    end

    random_sections = quote_indices.shuffle!.take(4)

    return random_sections
  end

  def get_lit (author)
    literary_corpus = open("literary_corpus.txt", "a")
    literary_corpus.truncate(0)

    sections = collect_random_sections (author)

    sections.each do |section|
      response = HTTParty.get(LIT_BASE_URI + "action=parse&format=json&page=#{author}&prop=text&section=#{section}&disableeditsection=")
      lit = response["parse"]["text"]["*"]
      literary_corpus << lit
    end

    literary_corpus.close

  end

  def clean_lit
    original_corpus = open("literary_corpus.txt", "r")
    clean_corpus = open("literary_corpus_temp.txt", "a")
    quotes = original_corpus.read
    # Cleaning the literary quotes
    clean_quotes = Sanitize.fragment(quotes, :remove_contents => ['h3', 'dd','a', 'i'])
    clean_quotes.delete!("\n")
    clean_quotes.squeeze!(" ")
    clean_corpus.write(clean_quotes)

    original_corpus.close
    clean_corpus.close

    File.rename("literary_corpus.txt", "literary_corpus.bak")
    File.rename("literary_corpus_temp.txt", "literary_corpus.txt")
  end

end
