require 'spec_helper.rb'
require 'player'
require 'card'

describe "An instance of", Player do
  before :each do
    @player = Player.new
  end

  context "when new" do

    it "should not have a hand" do
      @player.hand.should be_nil
    end

    context "when initialized without a name" do
      it "Should have a default name" do
        @player.name.should_not be_empty
      end
    end

    context "when initialized with a name" do
      before do
        @player_with_name = Player.new("uzzal")
      end

      it "should have the name provided" do
        @player_with_name.name.should eql "uzzal"
      end

    end
  end

  context "when multiple players present" do
    before do
      @another_player = Player.new
    end

    it "each should have a unique id" do
      @player.id.should_not eql @another_player.id
    end

    context "when players have card" do
      before do
        player_cards = [
          Card.new(1, 11), Card.new(2, 11), Card.new(3, 12)
        ]
        another_player_cards = [
          Card.new(3, 2), Card.new(2, 3), Card.new(1, 14)
        ]
        @player.hand = player_cards
        @another_player.hand = another_player_cards
      end

      it "cards should not be empty" do
        @player.hand.cards.should_not be_empty
      end

      context "#wins" do

        it "player with highest cards should win" do
          @another_player.wins(@player).should eql true
        end

        context "when players have same cards" do
          before do
            player_cards = [
              Card.new(1, 5), Card.new(1, 9), Card.new(1, 13)
            ]
            another_player_cards = [
              Card.new(2, 5), Card.new(2, 9), Card.new(2, 13)
            ]
            @player.hand = player_cards
            @another_player.hand = another_player_cards
          end

          it "the player that shows should loose" do
            # another player is showing the cards, hence looses
            @another_player.wins(@player).should eql false
          end
        end
      end

    end
  end
end

