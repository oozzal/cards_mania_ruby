require 'card'

class Deck

  attr_reader :cards

  def initialize
    @cards = []
    SUITS.each do |suit, suit_value|
      FACES.each do |face,face_value|
        @cards << Card.new(suit_value, face_value)
      end
    end
  end

  def shuffle!
    @cards.shuffle!
  end

end

