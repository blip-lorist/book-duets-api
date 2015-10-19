class LyricalCorpus

  LYRICS_BASE_URI = "http://api.musixmatch.com/ws/1.1/"

  def initialize
  end

  def build (musician)
    get_lyrics (musician)
    clean_lyrics (musician)
    log_build (musician)
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

    if track_ids.length == 0
      raise "LyricsNotFound"
    else
      random_tracks = track_ids.shuffle!.take(5)
      return random_tracks
    end
  end

  def get_lyrics (musician)
    musician_en = url_encode(musician)

    lyrical_corpus = ""

    track_ids = collect_random_tracks (musician_en)

    track_ids.each do |id|
      response = HTTParty.get(LYRICS_BASE_URI + "track.lyrics.get?track_id=#{id}&apikey=#{ENV['MUSIX_MATCH']}")
      json_response = JSON.parse(response)
      lyrics = json_response["message"]["body"]["lyrics"]["lyrics_body"]
      lyrical_corpus << " " + lyrics
    end

    $redis.set(musician, lyrical_corpus)
  end

  def clean_lyrics (musician)
    lyrics = $redis[musician]

    # Cleaning the lyrics
    lyrics.gsub!("******* This Lyrics is NOT for Commercial use *******", "")
    lyrics.gsub!("...", "")

    $redis.multi do
      $redis[musician] = lyrics
      $redis.expire(musician, 300)
    end
    # TODO: This should expire within a certain amount of time
  end

  def log_build (musician)
    $redis.zincrby("Musicians", 1.0, musician)
  end
end
