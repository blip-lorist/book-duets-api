class BookDuetsController < ApplicationController
  before_filter :authenticate

  require "./lib/lyrical_corpus"
  require "./lib/literary_corpus"

  def custom_duet
    begin

    missing_params_check

    musician = params["musician"].gsub("_", " ").titlecase
    author = params["author"].gsub("_", " ").titlecase
    filter_level = params["filter_level"]

      build_corpora(musician, author)
      book_duet = new_duet(musician, author, filter_level)
      render json: {musician: musician, author: author, book_duet: book_duet}, status: :ok
    rescue RuntimeError => specific_error
      render json: {
        error: specific_error.message
        }, status: :ok
    end
  end

  private

  def missing_params_check
    if params["musician"] == nil
      raise "Please include a musician's name."
    elsif params["author"] == nil
      raise "Please include an author's name."
    elsif params["filter_level"] == nil
      raise "Please include a filter level."
    end
  end

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

  def new_duet (musician, author, filter_level)
    temp_dict = MarkyMarkov::TemporaryDictionary.new
    temp_dict.parse_string("#{$redis[musician]}")
    temp_dict.parse_string("#{$redis[author]}")

    mashup = temp_dict.generate_3_sentences
    filter(mashup, filter_level)

    temp_dict.clear!

    return mashup
  end

  def filter(mashup, filter_level)
    if filter_level == "none"
      mashup = $edgy_filter.sanitize(mashup)
    elsif filter_level == "med"
      mashup = $edgy_filter.sanitize(mashup)
    elsif filter_level == "hi"
      mashup = $safe_filter.sanitize(mashup)
    else
      raise "Please include a filter_level: none, med, or hi"
    end
  end
end
