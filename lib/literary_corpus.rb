
class LiteraryCorpus
  # URI for sections
  # https://en.wikiquote.org/w/api.php?action=parse&format=json&prop=sections&page=Neil_Gaiman
  # https://en.wikiquote.org/w/api.php?action=parse&format=json&page=Neil_Gaiman&prop=text&section=2&disableeditsection=
  # API sandbox link
  # https://en.wikipedia.org/wiki/Special:ApiSandbox

  LIT_BASE_URI = "https://en.wikiquote.org/w/api.php?"

  def initialize
  end


  def build (author)
    get_lit (author)
    clean_lit (author)
  end

  private

  # ____ LIT METHODS ____ #

  # Collect Wikiquote sections
  def collect_random_sections (author)

    response = HTTParty.get("https://en.wikiquote.org/w/api.php?action=parse&format=json&prop=sections&page=#{author}")
    if response["error"] || response["parse"]["sections"].empty?
      raise "AuthorNotFound"
    else
      sections = response["parse"]["sections"]

      quote_indices = []

      sections.each do |section|
        if section["number"].to_f < 2
          quote_indices << section["index"]
        end
      end

      random_sections = quote_indices.shuffle!.take(3)

      return random_sections
    end
  end

  def get_lit (author)
    literary_corpus = ""

    sections = collect_random_sections (author)

    sections.each do |section|
      response = HTTParty.get(LIT_BASE_URI + "action=parse&format=json&page=#{author}&prop=text&section=#{section}&disableeditsection=")
      lit = response["parse"]["text"]["*"]
      literary_corpus << lit
    end

    $redis.set("#{author}", literary_corpus)
  end

  def clean_lit (author)
    quotes = $redis[author]

    clean_quotes = Sanitize.fragment(quotes, :remove_contents => ['h3', 'dd','a', 'i'])
    clean_quotes.delete!("\n")
    clean_quotes.squeeze!(" ")

    banned_patterns = ["Ch.", "Ch ", "Chapter", "Line"]

    banned_patterns.each do |pattern|
      clean_quotes.gsub!(pattern, "")
    end

    $redis[author] = clean_quotes
  end
end
