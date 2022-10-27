require "pry"
require "./lib/turn"

class Round
  attr_reader :deck, :turns

  def initialize(deck)
    @deck = deck
    @turns = []
    @correct_answers = 0
  end

  def current_card
    @deck.cards.first
  end

  def take_turn(guess)
    turn = Turn.new(guess, current_card)
    @turns << turn
    @deck.cards.rotate!(1)
    if turn.guess == turn.card.answer
      @correct_answers += 1
    end
    turn
  end

  def number_correct
    @correct_answers
  end

  def number_correct_by_category(category)
    x = 0
    @turns.each do |turn|
      if category == turn.card.category
        if turn.guess == turn.card.answer
          x += 1
        end
      end
    end
    x
  end

  def percent_correct
    (number_correct.to_f / @turns.count) * 100
  end

  def percent_correct_by_category(category)
    count = 0
    @turns.each do |turn|
      if turn.card.category == category
        count += 1
      end
    end
    (number_correct_by_category(category).to_f / count) * 100
  end
end