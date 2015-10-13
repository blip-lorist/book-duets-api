class BookDuetsController < ApplicationController

  def custom_duet
    duos = request.parameters
    render json: {duo_info: duos}, status: :ok
  end

end
