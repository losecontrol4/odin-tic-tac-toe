require_relative 'board'
require_relative 'player'

SCORE_TO_WIN = 5

# get player names and give an introduction

puts '-----------------------------------------------------'
puts "Welcome, you two will play tic tac toe to the death! First to #{SCORE_TO_WIN} wins!"
puts 'If you win, you be X in the next round. In the case of a draw, you will switch tokens(X or O).'
puts 'Please enter one of your names:'
player1 = gets.chomp
puts "Welcome #{player1}!"
puts 'Please enter the other persons name:'
player2 = gets.chomp
puts "Welcome #{player2}!"

if player1 == player2 # If the players enter the same exact string, then create a way to differ between the two
  puts "well that's confusing..."
  player2 += '2'
  puts "the second player is now #{player2}"
end

# create player object
player1 = Player.new(player1)
player2 = Player.new(player2)
player1, player2 = player2, player1 if rand(0..1).zero? # randomly swaps who is X first

# plays the game
while player1.score < SCORE_TO_WIN && player2.score < SCORE_TO_WIN
  # create game
  game = Board.new(player1, player2) # these inputs swap often throughout the program, dictating who is X.
  result = game.play_game

  puts 'The score is:'
  puts "#{player1.name}: #{player1.score}"
  puts "#{player2.name}: #{player2.score}"
  puts "First to #{SCORE_TO_WIN} wins"

  if result.nil? # aka the game resulted in a draw, therefore switch (this will swap who is x and o)
    player1, player2 = player2, player1
  elsif result == player2
    player1, player2 = player2, player1
  end

end

# ends with results
puts "#{player1.name} wins!" # player1
puts "#{player2.name} tried their best by winning #{player2.score} rounds!"
puts "Yet #{player1.name}  is cooler than #{player2.name} because they won!"
