require 'deck'

FactoryGirl.define do
  factory :game do
    deck Deck.new
    no_of_players 2
  end
end

