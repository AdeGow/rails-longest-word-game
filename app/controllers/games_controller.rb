require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    # TODO display a new random grid and a form.
    # The form will be submitted (with POST) to the score action.
    alphabet = ('a'..'z').to_a
    @letters = alphabet.sample(10)
  end

  def score
    @answer = params[:answer]
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word_serialized = URI.open(url).read
    @word = JSON.parse(word_serialized)
    @random_letters = params[:letters]

    while @answer.each do | letter |
      @random_letters.include? "#{letter}"

      if @word["found"] == true
        @validation = "CONGRATULATIONS! #{@answer} is a valid english word"

      elsif @word["found"] == false
        @validation = "Sorry but #{@answer} does not seem to be a valid English word."

     else
        @validation = "Sorry but #{@answer} can't be built out of #{@letters}"
      end
    end
  end
end
