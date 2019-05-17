require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    if params[:word].chars.all? { |letter| params[:word].upcase.chars.count(letter) <= params["letters"].split.count(letter) && params["letters"].downcase.split.include?(letter) }
      response = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
      json = JSON.parse(response.read)
      if json['found']
        @result = "Congratulations! #{params[:word]} is a valid English word! Your score is: #{params[:word].length*params[:word].length} "
      else
        @result = "Sorry but #{params[:word]} does not seem to be a valid English word...Score: 0"
      end
    else
      @result = "Sorry but #{params[:word]} can't be build out of #{params["letters"]}! Score: 0"
    end
  end
end
