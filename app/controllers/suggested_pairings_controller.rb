class SuggestedPairingsController < ApplicationController

  def random_pairing
    offset = rand(SuggestedPairing.count)
    # Offsetting, since rando nums don't necessarily
    # correspond with record ids.
    random_pairing = SuggestedPairing.offset(offset).first

    markov = MarkyMarkov::Dictionary.new("./dictionaries/#{random_pairing.persisted_dictionary}")

    book_duet = markov.generate_3_sentences

    render json: {
      author: random_pairing.author,
      musician: random_pairing.musician,
      news_source: random_pairing.news_source,
      book_duet: book_duet
      }, status: :ok

  end

end
