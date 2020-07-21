# class manages new board set-up and new players.
class Board
  attr_accessor :game_array
  attr_accessor :win_trigger
  attr_accessor :plr1_win_check
  attr_accessor :plr2_win_check
  attr_accessor :win_array

  def initialize
    @game_array = Array.new(9, '#')
    @player_hash = {}
    @win_trigger = 'false'
    @plr1_win_check = []
    @plr2_win_check = []
    @win_array = [[0, 1, 2], [0, 3, 6], [0, 4, 8], [1, 4, 7], [2, 5, 8], [2, 4, 6], [3, 4, 5], [6, 7, 8]]
  end

  def intro_text
    puts "////////////////////////////////////////////////////////////\n\n"
    puts "Welcome to Tic Tac Toe, A.K.A. Naughts and Crosses!\n\n"
    puts "Each space on the game-board is represented by a number:\n\n"
    puts "#{reference_board}"
    puts "Good Luck!\n\n"
    puts "/////////////////////////////////////////////////////////////\n\n"
  end

  public

  def players
    @i = 0
    until @i > 1
      puts "Player #{@player_hash.length + 1}, What is your name?"
      name = gets.chomp
      passname = @player_hash.select { |find_name | find_name == name}
      if passname.empty? == false
        name = name + "_2"
      end
      @i == 0 ? @player_hash[name] = 'O' : @player_hash[name] = 'X' 
      puts "\n\nPlayer #{@player_hash.keys[@i]} is: #{@player_hash.values[@i]}\n\n"
      @i += 1
    end
  end

  def show_board
    puts "\n\n   #{game_array[0]} | #{game_array[1]} | #{game_array[2]} "
    puts "   #{game_array[3]} | #{game_array[4]} | #{game_array[5]} "
    puts "   #{game_array[6]} | #{game_array[7]} | #{game_array[8]} \n\n"
  end

  def reference_board
    puts "Reference board : \n\n"
    puts '   0 | 1 | 2 '
    puts '   3 | 4 | 5 '
    puts '   6 | 7 | 8 '
  end

  def change_symbol(user_number, symbol)
    @game_array[user_number] = symbol
    if symbol == 'O'
      @plr1_win_check.push(user_number)
      check_for_win(@plr1_win_check, 0)
    elsif symbol == 'X'
      @plr2_win_check.push(user_number)
      check_for_win(@plr2_win_check, 1)
    end
  end

  def play_round

    @player_hash.each do |name, symbol|
      turn_complete = false
      while turn_complete == false
        reference_board
        show_board
        puts "#{name}, input a number from 0 - 8"
        number_in = gets.chomp.to_i
        if number_in >= 0 && number_in <= 8
          if @game_array[number_in] != '#'
            puts "Oops, that space has been taken already by #{@game_array[number_in]}\n\n"
          else
            turn_complete = true
          end
        end
      end
      change_symbol(number_in, symbol)

      break if @win_trigger != 'false'
      # @game_array.include?("#") ? @win_trigger == false : @win_trigger == 'draw'
    end
  end

  def check_for_win (player_array, player)
    @player_array = player_array
    if @player_array.length > 2
      if @game_array.include?('#') == false
        @win_trigger = 'draw'
        puts "Oh no! It's a draw. It\'s the taking part that counts."
      else
        @win_array.each do |group|
          check_sum = group - @player_array
          if check_sum == [] && @win_trigger == 'false'
            puts "Using #{group} ...\n\n"
            puts "Player #{@player_hash.keys[player]} wins!"
            @win_trigger = 'true'
          end
        end
      end
    end
  end
end

new_game = Board.new
new_game.intro_text
new_game.players
# new_game.show_board

loop do
  new_game.play_round
  if new_game.win_trigger != 'false'
    new_game.show_board
    return
  end
end 