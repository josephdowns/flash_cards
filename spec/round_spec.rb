require './lib/round'
require './lib/turn'
require './lib/card'
require './lib/deck'
require 'pry'

RSpec.describe Round do
  before :each do
    @card1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    @card2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?",
      "Mars", :STEM)
    @card3 = Card.new("Describe in words the exact direction that is 697.5 degrees clockwise from due north.",
      "North north west", :STEM)
    cards = [@card1, @card2, @card3]
    @deck = Deck.new(cards)
    @round = Round.new(@deck)
  end

  it 'exists' do
    expect(@round).to be_an_instance_of(Round)
    expect(@round.deck).to eq(@deck)
    expect(@round.turns).to eq([])
  end

  it 'sees what card is next' do
    expect(@round.current_card).to eq(@card1)
  end

  it 'takes a turn' do
    new_turn = @round.take_turn("Juneau")

    expect(new_turn).to be_an_instance_of(Turn)
    expect(new_turn.correct?).to be(true)
    expect(@round.turns).to eq([new_turn])
    expect(@round.current_card).to eq(@card2)
  end

  it 'can take two turns' do
    @round.take_turn("Juneau")
    @round.take_turn("Venus")

    expect(@round.turns.count).to eq(2)
    expect(@round.turns.last.feedback).to eq("Incorrect.")
  end

  it 'keeps track of data' do
    @round.take_turn("Juneau")
    @round.take_turn("Venus")

    expect(@round.number_correct).to eq(1)
    expect(@round.number_correct_by_category(:Geography)).to eq(1)
    expect(@round.number_correct_by_category(:STEM)).to eq(0)
    expect(@round.percent_correct).to eq(50.0)
    expect(@round.percent_correct_by_category(:Geography)).to eq(100.0)
  end
end