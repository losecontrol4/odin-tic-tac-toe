# Class board represents the "board" in tic tac toe.
class Board
  @@WINNING_POSITIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
  # this list was so small it was much easier (and efficent) to hard code in instead of creating logic to find three in a row-especially considering how often it is called. Possibiliy one can use a set to speed it up if needed.
  attr_accessor :gameboard, :token_arrays

  def initialize(p1, p2)
    @gameboard = Array.new(9, ' ')
    @token_arrays = # Contains an array of all the x's and o's chosen. allows me to quickly check if a solution has been reached without parsing through the board
      Array.new(2) do
        []
      end
    @round_over = false
    @players = [p1, p2]
    @players[0].token = 'X'
    @players[1].token = 'O'
    @winner = nil
    @turns = 0
  end

  def play_game
    # plays a game of tic tac toe, returns the winning player or nil in case of a draw
    welcome
    game_over = false
    until game_over
      puts to_s
      @players[0].move(self)
      @turns += 1

      if over?(0)
        game_over = true
        next
      end

      puts to_s
      @players[1].move(self)
      @turns += 1

      game_over = true if over?(1)
    end
    puts to_s

    if @winner.nil?
      puts 'DRAW!'
      nil
    else
      puts "The winner is #{@winner.name}"
      @winner.increment_score
      @winner
    end
  end

  def to_s # overwrites the to_s method which is automatically used by puts. This creates what is shown when you call puts Board
    new_string = ''
    3.times do |x|
      new_string += row_to_s(x)
      new_string += "\n  ____|_____|____\n      |     |    \n" if x < 2
    end
    new_string
  end

  private

  def welcome
    puts "Welcome to tic tac toe! This game is meant for two players. #{@players[0].name} will be X and #{@players[1].name} will be O."
    puts 'To choose a square, enter in a number one through nine, ordered like a keypad.'
  end

  def over?(player_index)
    if @turns < 5 # it is impossible for either player to win in less than 5 turns, therefore this check is a waste of runtime until there has been 5 turns taken
      return false
    end
    return true if @turns == 9

    @@WINNING_POSITIONS.each do |winning_position|
      if (winning_position - token_arrays[player_index]).empty? #don't need to worry if token array is empty because this is only checked after 4 turns already happened.
        @winner = @players[player_index]
        # checks if all the values of winning_position are in token_array
      end
    end

    @winner != nil
  end

  def row_to_s(x)
    "   #{@gameboard[x * 3 + 0]}  |  #{@gameboard[x * 3 + 1]}  |  #{@gameboard[x * 3 + 2]} "
  end
end

#   -  |  -  |  -
#  ____|_____|____
#      |     |
#   -  |  -  |  -
#  ____|_____|____
#      |     |
#   -  |  -  |  -
