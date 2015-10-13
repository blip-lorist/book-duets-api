class BookDuetsController < ApplicationController

  require "./lib/lyrical_corpus"
  require "./lib/literary_corpus"


  def custom_duet
    duo = request.parameters

    musician = duo["musician"]
    author = duo["author"]

    # Build corpora
    LyricalCorpus.new.build_lyrical_corpus (musician)
    LiteraryCorpus.new.build_literary_corpus (author)

    #Stop, mashup time!
    book_duet = new_duet
    render json: {author: duo["author"], musician: duo["musician"], mashup: book_duet}, status: :ok
    # TODO: Error handling!
  end


  
  private

  def new_duet
    temp_dict = MarkyMarkov::TemporaryDictionary.new
    temp_dict.parse_file "literary_corpus.txt"
    temp_dict.parse_file "lyrical_corpus.txt"

    mashup = temp_dict.generate_3_sentences
    temp_dict.clear!

    return mashup
  end

end
