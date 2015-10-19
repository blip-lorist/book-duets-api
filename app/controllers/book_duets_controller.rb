class BookDuetsController < ApplicationController
  require "./lib/lyrical_corpus"
  require "./lib/literary_corpus"

  def custom_duet
    musician = params["musician"].gsub("_", " ")
    author = params["author"].gsub("_", " ")

    begin
      build_corpora(musician, author)
      book_duet = new_duet(musician, author)
      render json: {musician: musician, author: author, mashup: book_duet}, status: :ok
    rescue RuntimeError => specific_error
      render json: {
        error: specific_error.message,
        suggestions: "Please ensure names are spelled correctly and include special characters."
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

  def build_corpora (musician, author)
    unless $redis.exists(musician)
      lyrical_corpus = LyricalCorpus.new(musician)
      lyrical_corpus.build
      # LyricalCorpus.new.build (musician)
    end

    unless $redis.exists(author)
      literary_corpus = LiteraryCorpus.new(author)
      literary_corpus.build
    end
  end

  def new_duet (musician, author)
    temp_dict = MarkyMarkov::TemporaryDictionary.new
    temp_dict.parse_string("#{$redis[musician]}")
    temp_dict.parse_string("#{$redis[author]}")

    mashup = temp_dict.generate_3_sentences
    temp_dict.clear!

    return mashup
  end
end
