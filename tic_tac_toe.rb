ttt_array = [*1..9]
ttt_hash = {}
ttt_array.each { | number |
  ttt_hash[number] = '#'
} 
player_hash = {}

class Board
  attr_reader :starter_hash
  def initialize(starter_hash) 
    @starter_hash = starter_hash
  end

  public
  def players(player_hash)
    puts "Player #{player_hash.length + 1}, What is your name?"
    name = gets.chomp
    if  player_hash.length == 0
      player_hash[name] = 'O'
      puts "Player #{player_hash.keys[0]} is: #{player_hash.values[0]}"
    else
      player_hash[name] = 'X'
      puts "Player #{player_hash.keys[1]} is: #{player_hash.values[1]}"
    end
  end

  public
  def show_board
    puts 'Your board is laid out like this:
    '
    puts ' ' + @starter_hash[1] + ' | ' + @starter_hash[2] + ' | ' + @starter_hash[3]
    puts ' ' + @starter_hash[4] + ' | ' + @starter_hash[5] + ' | ' + @starter_hash[6]
    puts ' ' + @starter_hash[7] + ' | ' + @starter_hash[8] + ' | ' + @starter_hash[9] + '
    '
  end

  public
  def change_symbol(user_number, symbol)
    @starter_hash[user_number] = symbol
  end

  public
  def check_for_win(ttt_hash)
    # ttt_hash.each { | key, value |
      plr2_prog = ttt_hash.select { | key, value | value == 'X'}
      puts plr2_prog
      plr2_prog.each { | key | 
        puts key('X')
        # caclulator += key.to_i
        # puts caclulator
      }
    # }
  end

end

puts <<EOF

Welcome to Tic Tac Toe

The positions are numbered like this:

 1 | 2 | 3
 4 | 5 | 6
 7 | 8 | 9 

EOF

new_game = Board.new(ttt_hash)
2.times do
new_game.players(player_hash)
end
new_game.show_board

# puts player_hash

while ttt_hash.has_value?('#') do
  
  player_hash.each { |name, symbol| 
    puts "#{name},input a number from 1 - 9"
    number_in = gets.chomp.to_i
    if number_in >=1 && number_in <= 9
      new_game.change_symbol(number_in, symbol)
      new_game.show_board
    else
      puts 'Please enter a number from 1 - 9'
    end
    new_game.check_for_win(ttt_hash)
  }
# else
#   return
end