require './lib/card'
require './lib/deck'
require './lib/turn'
require 'pry'

RSpec.describe Deck do
  before :each do
    @card1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    @card2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?",
      "Mars", :STEM)
    @card3 = Card.new("Describe in words the exact direction that is 697.5 degrees clockwise from due north.",
      "North north west", :STEM)
    cards = [@card1, @card2, @card3]
    @deck = Deck.new(cards)
  end

  it "exists" do
    expect(@deck).to be_an_instance_of(Deck)
    expect(@deck.cards).to eq([@card1, @card2, @card3])
  end

  it 'can count' do
    expect(@deck.count).to eq(3)
  end

  it 'can list cards by category' do
    expect(@deck.cards_in_category(:STEM)).to eq([@card2, @card3])
    expect(@deck.cards_in_category(:Geography)).to eq([@card1])
    expect(@deck.cards_in_category("Pop Culture")).to eq([])
  end
end