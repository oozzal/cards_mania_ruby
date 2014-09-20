require 'spec_helper.rb'
require 'game'
require 'deck'

describe 'An instance of', Game do
  before :each do
    @game = FactoryGirl.build(:game)
  end

  it 'should be properly initialized' do
    expect(@game).to be_a(Game)
    expect(@game.deck).to be_a(Deck)
    expect(@game.players).to be_a(Array)
  end

  context 'when new' do
    it 'should have no player' do
      expect(@game.players).to be_empty
    end
  end

  context '#start' do
    context '#start("deal")' do
      before do
        @game.start('deal')
      end

      it 'should have one player' do
        @game.players.length.should eql 1
      end
    end

    context '#start("play")' do
      before do
        # for initialize_players method
        @game.stub(:gets).and_return("2")
        # To prevent printing to the test screen
        @game.stub(:print)
        @game.stub(:puts)
        # The sequence of calls in start method
        @game.initialize_players
        @game.deal
        @game.declare_winner
      end

      it 'should initialize players properly' do
        @game.players.size.should eql(2)
      end

      it 'should evenly deal the cards to the players' do
        @game.players[0].hand.should_not be_nil
      end

      it 'there should be one winner' do
        @game.winners.size.should eql(1)
      end

    end

  end
end
