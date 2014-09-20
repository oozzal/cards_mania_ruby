require 'hand'

class Player

  attr_reader :name, :hand, :id
  @@player_id = 0

  def initialize(name="")
    @@player_id += 1
    @id = @@player_id
    @name = name.empty? ? "Player#{@id}" : name
  end

  def hand=(cards)
    @hand = Hand.new(cards)
  end

  def wins(player)
    self.hand.is_greater_than? player.hand
  end

end

