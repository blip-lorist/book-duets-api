class BookDuetsController < ApplicationController

  require "./lib/lyrical_corpus"
  require "./lib/literary_corpus"


  def custom_duet
    duo = request.parameters

    musician = duo["musician"]
    author = duo["author"]

    LyricalCorpus.new.build_lyrical_corpus(musician)
    LiteraryCorpus.new.build_literary_corpus(author)

    render json: {author: duo["author"], musician: duo["musician"]}, status: :ok
  end

end
