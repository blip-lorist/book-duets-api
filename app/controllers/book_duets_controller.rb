class BookDuetsController < ApplicationController

  def custom_duet
    duo = request.parameters
    render json: {author: duo["author"], musician: duo["musician"]}, status: :ok
  end

end
