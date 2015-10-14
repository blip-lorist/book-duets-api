class LyricalCorpus

  LYRICS_BASE_URI = "http://api.musixmatch.com/ws/1.1/"

  def initialize
    @path = "lyrical_corpus.txt"
    @backup = "lyrical_corpus.bak"
  end

  def build (musician)
    get_lyrics (musician)
    clean_lyrics
  end

  private

  # ____ LYRIC METHODS ____ #
  def collect_random_tracks (musician)
    response = HTTParty.get(LYRICS_BASE_URI + "track.search?q_artist=#{musician}&f_has_lyrics=1&page_size=20&format=json&apikey=#{ENV['MUSIX_MATCH']}")
    json_response = JSON.parse(response)
    tracks = json_response["message"]["body"]["track_list"]

    track_ids = []
    tracks.each do |track|
      track_ids << track["track"]["track_id"]
    end

    random_tracks = track_ids.shuffle!.take(5)

    return random_tracks
  end

  def get_lyrics (musician)
    lyrical_corpus = open(@path, "a")
    #Remove old lyrics
    lyrical_corpus.truncate(0)

    track_ids = collect_random_tracks (musician)

    track_ids.each do |id|
      response = HTTParty.get(LYRICS_BASE_URI + "track.lyrics.get?track_id=#{id}&apikey=#{ENV['MUSIX_MATCH']}")
      json_response = JSON.parse(response)
      lyrics = json_response["message"]["body"]["lyrics"]["lyrics_body"]
      lyrical_corpus << lyrics
    end
    lyrical_corpus.close
  end

  def clean_lyrics

    original_corpus = open(@path, "r")
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
    File.rename(@path, @backup)
    # The clean lyrical corpus becomes the main corpus file
    File.rename("lyrical_corpus_temp.txt", @path)
  end
end
