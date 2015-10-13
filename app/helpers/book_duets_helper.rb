module BookDuetsHelper

# URI for sections
# https://en.wikiquote.org/w/api.php?action=parse&format=json&prop=sections&page=Neil_Gaiman
# https://en.wikiquote.org/w/api.php?action=parse&format=json&page=Neil_Gaiman&prop=text&section=2&disableeditsection=
# API sandbox link
# https://en.wikipedia.org/wiki/Special:ApiSandbox

  LYRICS_BASE_URI = "http://api.musixmatch.com/ws/1.1/"
  LIT_BASE_URI = "https://en.wikiquote.org/w/api.php?"

  def build_lyrical_corpus (musician)
    collect_tracks
    get_lyrics
    clean_lyrics
  end

  def build_literary_corpus (author)
    get_lit
    clean_lit
  end

  private

  # ____ LYRIC METHODS ____ #
  def collect_tracks
    # artist_name = params[:artist]
    response = HTTParty.get(LYRICS_BASE_URI + "track.search?q_artist=nickelback&f_has_lyrics=1&page_size=5&format=json&apikey=#{ENV['MUSIX_MATCH']}")
    json_response = JSON.parse(response)
    tracks = json_response["message"]["body"]["track_list"]

    track_ids = []
    # TODO: Think about making this random, rather than grabbing the first 5
    tracks.each do |track|
      track_ids << track["track"]["track_id"]
    end

    return track_ids
  end

  def get_lyrics
    lyrical_corpus = open("lyrical_corpus.txt", "a")
    #Remove old lyrics
    lyrical_corpus.truncate(0)

    track_ids = collect_tracks

    track_ids.each do |id|
      response = HTTParty.get(LYRICS_BASE_URI + "track.lyrics.get?track_id=#{id}&apikey=#{ENV['MUSIX_MATCH']}")
      json_response = JSON.parse(response)
      lyrics = json_response["message"]["body"]["lyrics"]["lyrics_body"]
      lyrical_corpus << lyrics
    end
    lyrical_corpus.close
  end

  def clean_lyrics

    original_corpus = open("lyrical_corpus.txt", "r")
    clean_corpus = open("lyrical_corpus_temp.txt", "a")
    lyrics = original_corpus.read

    # Cleaning the lyrics
    lyrics.gsub!("******* This Lyrics is NOT for Commercial use *******", "")
    lyrics.gsub!("...", "")
    clean_corpus.write(lyrics)
    # TODO: Obscenity filter? Or should this happen at the very end of the mashup?
    original_corpus.close
    clean_corpus.close

    # The original lyrical corpus is now a backup file
    File.rename("lyrical_corpus.txt", "lyrical_corpus.bak")
    # The clean lyrical corpus becomes the main corpus file
    File.rename("lyrical_corpus_temp.txt", "lyrical_corpus.txt")
  end

  # ____ LIT METHODS ____ #

  # Collect Wikiquote sections
  def collect_random_sections

    response = HTTParty.get("https://en.wikiquote.org/w/api.php?action=parse&format=json&prop=sections&page=Neil_Gaiman")

    sections = response["parse"]["sections"]

    quote_indices = []

    sections.each do |section|
      if section["number"].to_f < 2
        quote_indices << section["index"]
      end
    end

    random_sections = quote_indices.shuffle!.take(5)

    return random_sections
  end

  def get_lit
    literary_corpus = open("literary_corpus.txt", "a")
    literary_corpus.truncate(0)

    sections = collect_random_sections

    sections.each do |section|
      response = HTTParty.get(LIT_BASE_URI + "action=parse&format=json&page=Neil_Gaiman&prop=text&section=#{section}&disableeditsection=")
      lit = response["parse"]["text"]["*"]
      literary_corpus << lit
    end

    literary_corpus.close

  end

  def clean_lit

  end
end
