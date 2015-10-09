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

    track_ids = collect_tracks

    track_ids.each do |id|
      response = HTTParty.get(BASE_URI + "track.lyrics.get?track_id=#{id}&apikey=#{ENV['MUSIX_MATCH']}")
      lyrical_corpus << response
    end

    lyrical_corpus.close

  end
end
