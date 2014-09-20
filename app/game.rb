require 'deck'
require 'player'

class Game

  attr_accessor :deck, :players, :winners, :no_of_players

  def initialize
    @deck = Deck.new
    @players = []
    # NO_OF_PLAYERS.times { @players << Player.new }
  end

  def start(mode='play')
    @game_mode = mode
    if mode == 'deal'
      @no_of_players = 1
      @players << Player.new('Admin')
    else
      initialize_players
    end
    deal
    declare_winner
    show
  end

  def initialize_players
    print 'No. of players?: '
    @no_of_players = gets.to_i
    @no_of_players.times { |i|
      print "Player#{i+1}'s name?: "
      player_name = gets.chomp.strip.squeeze(" ")
      @players << Player.new(player_name)
    }
  end

  def deal
    @deck.shuffle!
    game_cards = @deck.cards.sample(@no_of_players * CARDS_PER_PLAYER)
    # Just in case above shuffle doesn't do anything
    game_cards.shuffle!
    @players.each do |player|
      player.hand = game_cards.pop(CARDS_PER_PLAYER)
    end
  end

  def declare_winner
    @winners = []
    @winners << @players.first
    @players.each_with_index do |player, index|
      next if index == 0
      @winners.pop && @winners << player if player.wins(@winners.first)
    end
  end

  def show
    output = "\n"
    @players.each do |player|
      output += "\n#{player.name} has\: ".cyan.bold if @game_mode != 'deal'
      player.hand.cards.each {|card| output += "#{card.picturize}  ".send(card.color) }
      output += "__#{player.hand.type}__".send(player.hand.color)
      output += ' --Winner!--'.green if @winners.include?(player)
      output += "\n"
    end
    output
  end

end
