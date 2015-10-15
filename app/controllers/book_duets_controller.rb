class BookDuetsController < ApplicationController

  require "./lib/lyrical_corpus"
  require "./lib/literary_corpus"


  def custom_duet
    begin
      build_corpora
      book_duet = new_duet
      render json: {author: params["author"], musician: params["musician"], mashup: book_duet}, status: :ok
    rescue RuntimeError => specific_error
      render json: {
        error: specific_error.message,
        suggestions: "Check your musician/author names to make sure they're spelled right. If so, try again in a few minutes."
        }, status: :ok
    end
  end

  def suggested_pairing
    offset = rand(BookDuet.count)
    # Offsetting, since rando nums don't necessarily
    # correspond with record ids.
    random_pairing = BookDuet.offset(offset).first

    markov = MarkyMarkov::Dictionary.new("./dictionaries/#{random_pairing.persisted_dictionary}")

    mashup = markov.generate_3_sentences

    render json: {
      author: random_pairing.author,
      musician: random_pairing.musician,
      news_source: random_pairing.news_source,
      mashup: mashup
      }, status: :ok

  end

  private

  def build_corpora
    musician = params["musician"]
    author = params["author"]
    LyricalCorpus.new.build (musician)
    LiteraryCorpus.new.build (author)
  end

  def new_duet
    temp_dict = MarkyMarkov::TemporaryDictionary.new
    temp_dict.parse_file "literary_corpus.txt"
    temp_dict.parse_file "lyrical_corpus.txt"

    mashup = temp_dict.generate_3_sentences
    temp_dict.clear!

    return mashup
  end
end
