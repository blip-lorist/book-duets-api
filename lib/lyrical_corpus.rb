require "erb"
include ERB::Util

class LyricalCorpus

  LYRICS_BASE_URI = "http://api.musixmatch.com/ws/1.1/"

  def initialize(musician)
    @musician = musician.gsub("_", " ")
    @musician_en = url_encode(@musician)
  end

  def build
    get_lyrics
    clean_lyrics
    log_build
    # cache_corpus
  end

  private

  # ____ LYRIC METHODS ____ #
  def collect_random_tracks
    response = HTTParty.get(LYRICS_BASE_URI + "track.search?q_artist=#{@musician_en}&f_has_lyrics=1&page_size=20&format=json&apikey=#{ENV['MUSIX_MATCH']}")
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

  def get_lyrics
    lyrical_corpus = ""

    track_ids = collect_random_tracks

    track_ids.each do |id|
      response = HTTParty.get(LYRICS_BASE_URI + "track.lyrics.get?track_id=#{id}&apikey=#{ENV['MUSIX_MATCH']}")
      json_response = JSON.parse(response)
      lyrics = json_response["message"]["body"]["lyrics"]["lyrics_body"]
      lyrical_corpus << " " + lyrics
    end

    $redis.set(@musician, lyrical_corpus)
  end

  def clean_lyrics
    lyrics = $redis[@musician]

    # Cleaning the lyrics
    lyrics.gsub!("******* This Lyrics is NOT for Commercial use *******", "")
    lyrics.gsub!("...", "")

    $redis[@musician] = lyrics
  end

  def log_build
    $redis.zincrby("Musicians Log", 1.0, @musician)
  end

  # def cache_corpus
  #   # If popular, cache for a week. Otherwise, cache for 5 min.
  #
  #   if $redis.zscore("Musicians Log", @musician) >= 5
  #     $redis.expire(@musician, 604800)
  #   else
  #     $redis.expire(@musician, 300)
  #   end
  # end

end
