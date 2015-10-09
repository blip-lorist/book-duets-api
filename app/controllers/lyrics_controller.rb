class LyricsController < ApplicationController

  BASE_URI = "http://api.musixmatch.com/ws/1.1/"


private

  def collect_tracks
  # @artist_name = params[:artist]
  response = HTTParty.get(BASE_URI + "track.search?q_artist=nickelback&f_has_lyrics=1&page_size=5&format=json&apikey=#{ENV['MUSIX_MATCH']}")
  json_response = JSON.parse(response)
  tracks = json_response["message"]["body"]["track_list"]

  track_ids = []

  tracks.each do |track|
    track_ids << track["track"]["track_id"]
  end

  return track_ids
  end

end
