class LyricsController < ApplicationController

  BASE_URI = "http://api.musixmatch.com/ws/1.1/"


#  http://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=15953433&apikey=b16e26c3037afc7bec268fa51386a23a


private

  def collect_tracks
  # artist_name = params[:artist]
  response = HTTParty.get(BASE_URI + "track.search?q_artist=nickelback&f_has_lyrics=1&page_size=5&format=json&apikey=#{ENV['MUSIX_MATCH']}")
  json_response = JSON.parse(response)
  tracks = json_response["message"]["body"]["track_list"]

  track_ids = []

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
      response = HTTParty.get(BASE_URI + "track.lyrics.get?track_id=#{id}&apikey=#{ENV['MUSIX_MATCH']}")
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

    original_corpus.close
    clean_corpus.close

    # The original lyrical corpus is now a backup file
    File.rename("lyrical_corpus.txt", "lyrical_corpus.bak")
    # The clean lyrical corpus becomes the main corpus file
    File.rename("lyrical_corpus_temp.txt", "lyrical_corpus.txt")
  end


end
