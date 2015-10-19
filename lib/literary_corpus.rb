
class LiteraryCorpus
  # URI for sections
  # https://en.wikiquote.org/w/api.php?action=parse&format=json&prop=sections&page=Neil_Gaiman
  # https://en.wikiquote.org/w/api.php?action=parse&format=json&page=Neil_Gaiman&prop=text&section=2&disableeditsection=
  # API sandbox link
  # https://en.wikipedia.org/wiki/Special:ApiSandbox

  LIT_BASE_URI = "https://en.wikiquote.org/w/api.php?"

  def initialize (author)
    @author = author.gsub("_", " ")
    @author_en = url_encode(@author)
  end


  def build
    get_lit
    clean_lit
    log_build
    cache_corpus
  end

  private

  # ____ LIT METHODS ____ #

  # Collect Wikiquote sections
  def collect_random_sections
    response = HTTParty.get("https://en.wikiquote.org/w/api.php?action=parse&format=json&prop=sections&page=#{@author_en}")
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

  def get_lit
    literary_corpus = ""

    sections = collect_random_sections

    sections.each do |section|
      response = HTTParty.get(LIT_BASE_URI + "action=parse&format=json&page=#{@author_en}&prop=text&section=#{section}&disableeditsection=")
      lit = response["parse"]["text"]["*"]
      literary_corpus << lit
    end

    $redis.set(@author, literary_corpus)
  end

  def clean_lit
    quotes = $redis[@author]

    clean_quotes = Sanitize.fragment(quotes, :remove_contents => ['h3', 'dd','a', 'i'])
    clean_quotes.delete!("\n")
    clean_quotes.squeeze!(" ")

    banned_patterns = ["Ch.", "Ch ", "Chapter", "Line"]

    banned_patterns.each do |pattern|
      clean_quotes.gsub!(pattern, "")
    end

    #Expire corpus in 5 minutes
    $redis[@author] = clean_quotes
  end

  def log_build
    $redis.zincrby("Authors Log", 1.0, @author)
  end

  def cache_corpus
    # If popular, cache for a week. Otherwise, cache for 5 min.

    if $redis.zscore("Authors Log", @author) >= 5
      $redis.expire(@author, 604800)
    else
      $redis.expire(@author, 300)
    end
  end
end
