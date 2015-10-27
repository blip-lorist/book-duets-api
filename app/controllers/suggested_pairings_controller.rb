class SuggestedPairingsController < ApplicationController
before_filter :authenticate

  def random_pairing
    begin

    filter_check
    filter_level = params["filter_level"]

    offset = rand(SuggestedPairing.count)
    # Offsetting, since rando nums don't necessarily
    # correspond with record ids.
    random_pairing = SuggestedPairing.offset(offset).first

    markov = MarkyMarkov::Dictionary.new("./dictionaries/#{random_pairing.persisted_dictionary}")

    book_duet = markov.generate_3_sentences

    filter(book_duet, filter_level)

    render json: {
      author: random_pairing.author,
      musician: random_pairing.musician,
      news_source: random_pairing.news_source,
      book_duet: book_duet,
      filter_level: filter_level
      }, status: :ok

    rescue RuntimeError => specific_error
      render json: {
        error: specific_error.message
        }, status: :ok
    end
  end

  private

  def filter_check
    if params["filter_level"] == nil
      raise "Please include a filter level."
    end
  end
end
