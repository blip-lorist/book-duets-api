class BookDuetsController < ApplicationController

  require "./lib/lyrical_corpus"

  def custom_duet
    duo = request.parameters

    musician = duo["musician"]

    LyricalCorpus.new.build_lyrical_corpus(musician)

    render json: {author: duo["author"], musician: duo["musician"]}, status: :ok
  end

end
