require './lib/turn'; require './lib/card'; require './lib/deck'; require './lib/round'
require 'pry'

@deck = [Card.new("What is 5 + 5?", "10", :Maths),
        Card.new("What is 5 * 6?", "30", :Maths),
        Card.new("What is the capital of Vermont?", "Mountpelier", :Capitals),
        Card.new("What is the atomic symbol of Mercury?", "Hg", :Chemistry)]
dk = Deck.new(@deck)
@round = Round.new(dk)

def start
  x = 1
  dc = @deck.count
  puts "Welcome! You're playing with #{dc} cards."
  puts "-" * 40
  until @round.turns.count == dc
    puts "This is card #{x} out of #{dc}"
    puts "Question: #{@round.current_card.question}"
    response = gets.chomp
    @round.take_turn(response)
    puts ""
    puts "#{@round.turns.last.feedback}"
    puts ""
    x += 1
  end
  puts "****** Game Over! ******"
  puts "You had #{@round.number_correct} answers out of #{@round.turns.count} for a total score of #{@round.percent_correct}%."
  puts "Maths - #{@round.percent_correct_by_category(:Maths)}% correct"
  puts "Capitals - #{@round.percent_correct_by_category(:Capitals)}% correct"
  puts "Chemistry - #{@round.percent_correct_by_category(:Chemistry)}% correct"
end

start