#Player class, contains infomation like player name, whether they are x or o currently, and their score.
class Player
  attr_reader :name, :score
  attr_accessor :token

  def initialize(name)
    @name = name
    @score = 0
    @token = 'X'
  end

  def increment_score
    @score += 1
  end 

  def move(board)
    #gets their input and puts it on the board if it's a valid move.
    puts "#{@name}, what's your move? (You are currently #{@token})"
    input_valid = false
    while(!input_valid) 
      input = gets.chomp
      if(input.length != 1 || !(input.to_i > 0 && input.to_i < 10 ))
        puts "#{@name}, please enter a valid number, 1 through 9"
        next # jumps to the top of the while loop
      end
      input = input.to_i
      if(board.gameboard[input - 1] != ' ')
        puts "#{@name}, please choose a spot that has not been chosen"
        next # jumps to the top of the while loop
      end
        input_valid = true
    end
    update_game(board, input) 
  end

  private
  def update_game(board, input) 
    board.gameboard[input - 1] = @token
    if(@token == 'X')
      board.token_arrays[0].push(input - 1)
    else 
      board.token_arrays[1].push(input - 1)
    end
  end

end
