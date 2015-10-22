class BookDuetsController < ApplicationController
  before_filter :authenticate

  require "./lib/lyrical_corpus"
  require "./lib/literary_corpus"

  def custom_duet
    musician = params["musician"].gsub("_", " ").titlecase
    author = params["author"].gsub("_", " ").titlecase

    begin
      build_corpora(musician, author)
      book_duet = new_duet(musician, author)
      render json: {musician: musician, author: author, book_duet: book_duet}, status: :ok
    rescue RuntimeError => specific_error
      render json: {
        error: specific_error.message,
        suggestions: "Please ensure names are spelled correctly and include special characters."
        }, status: :ok
    end
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
