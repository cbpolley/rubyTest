#mastermind class
class Combo
  attr_reader :make_or_break
  attr_accessor :starter_deck
  attr_accessor :user_guess
  attr_reader :clue_return
  attr_reader :return_log
  attr_reader :win_trigger
  attr_reader :round_count
  attr_reader :end_game_message

  def initialize
    @starter_deck = %w[a b c d e f]
    @clue_return_comp_memory = []
    @guess_comp_memory = []
    @keep_num = Array.new(4)
    @return_log = ['                    Your code                 Feedback', '         ---------------------------------------------------']
    @round_count = 0
    intro_text
    @combination = shuffle_deck
    player_names
  end

  def intro_text
    puts "///////////////////////////////////////////\n\n"
    puts "   Welcome to Mastermind!   \n\n"
    puts "   You have 12 guesses to crack the code, which is four letters. Each letter might be a, b, d, e, or f.\n\n"
    puts "   Please guess by typing in four letters, each separated by a comma (e.g. 'a,b,c,d').\n\n"
    puts "   The computer will give you feedback once you have guessed the code.\n\n"
    puts "   Correct letter in the right place = 'O' , correct letter in the wrong place = '#' , wrong letter and wrong place = x  \n\n"
    puts "///////////////////////////////////////////\n\n"
  end

  def start_game
    until @win_trigger == true
      if @make_or_break == 'cb'
        play_round
      else
        play_AI_round
      end
    end
    puts @end_game_message
  end

  def player_names
    puts "What\'s your name?"
    @name = gets.chomp
    until @make_or_break == 'cm' || @make_or_break == 'cb'
      puts "#{@name}, are you the Code-Maker (type: cm) or the Code-Breaker? (type: cb)"
      @make_or_break = gets.chomp
    end
    if @make_or_break == 'cb'
      puts "Good luck, Code-Breaker #{@name}!"
    else
      puts "Welcome, Code-Maker #{@name}. Enter your code..."
      @player_combination = sterilise_input
    end
  end

  def sterilise_input
    sterilise = []
    until sterilise.length == 4 && sterilise.all? { |letter| @starter_deck.include?(letter) }
      sterilise = gets.chomp.split(',')
      if sterilise.length != 4 || sterilise.all? { |letter| @starter_deck.include?(letter) } != true
        puts "Oops, you didn't do that quite right. Please try again."
      end
    end
    sterilise
  end

  def play_round
    @user_guess = []
    puts "\n\nGuess the code.... (e.g. 'a,b,c,d')"
    @user_guess = sterilise_input
    puts compare(@user_guess, @combination)
  end

  def play_AI_round
    @comp_decide_arr = Array.new(4)
    @AI_previous_guess = []
    if @round_count < 6
      @guess_letter = @starter_deck[round_count]
      @AI_guess = Array.new(4, @guess_letter)
    elsif @round_count == 6
      @AI_guess = []
      @clue_return_comp_memory.each_with_index do |clue_row, return_index|
        if clue_row.include?('O')
          clue_row.each_with_index do |clue, index|
            if clue == 'O'
              @guess_comp_memory[return_index].each_with_index do |letter, guess_row_index|
                @push_letter = letter
                if guess_row_index == index
                  @AI_guess.push(@push_letter)
                end
              end
            end
          end
        end
      end
    else
      until @guess_comp_memory.include?(@AI_guess) == false
        @AI_guess.shuffle!
      end
    end

    puts "\n\nBeep boop here is my guess: #{@AI_guess}"
    temp_array = Array.new
    @AI_guess.each do |letter|
      temp_array.push(letter)
    end
    @guess_comp_memory.push(temp_array)
    puts compare(@AI_guess, @player_combination)
    @clue_return_comp_memory.push(@clue_return)
  end

  private

  def compare(guess, combination)
    @guess = guess
    @clue_return = Array.new(4, 'x')
    @round_count += 1
    @win_trigger = true
    @guess_work = []
    @combination = combination
    @combination.each do |letter|
      @guess_work.push(letter)  
    end
    @guess_work.each_with_index do | letter, index |
      @index = index
      @letter = letter
      stop_delete_guess_work = false
      @guess.each_with_index do |sub_letter, sub_index|
        if sub_letter == @letter && stop_delete_guess_work == false
          if @index == sub_index
            @clue_return[@index] = 'O'
            @guess_work[sub_index] = nil
            stop_delete_guess_work = true
          end
        else
          @win_trigger = false
        end
      end
    end
    if @clue_return.all? {|clue| clue == 'O'} == false
      @win_trigger = false
      @guess.each do |sub_letter|
        if @guess_work.include?(sub_letter) 
          @clue_return[@guess_work.index(sub_letter)] = '#'
          @guess_work[@guess_work.index(sub_letter)] = nil
        end
      end
    end

    @win_trigger = true if @clue_return.all? { |clue| clue == 'O' }

    if @win_trigger == true
      if @make_or_break == 'cb'
        @end_game_message = "Congratulations #{@name}, you cracked the code #{@combination}!"
      else
        @end_game_message = "Beep boop that was too easy human! I cracked your code #{@combination}!"
      end
    end
    if @round_count == 12
      @win_trigger = true 
      if @make_or_break == 'cb'
        @end_game_message = "#{@name}, oh no! You ran out of turns and you did not crack the code: #{@combination}"
      else
        @end_game_message = "Beep boop WHAT!! #{@name}, you have bested me. I bow before your mighty intelligence. I did not crack the code: #{@combination}"
      end
    end
    @clue_return.shuffle!

    @round_count < 10 ? @return_log.push("Round #{@round_count}  :     #{guess}      #{@clue_return}") : @return_log.push("Round #{@round_count} :     #{guess}      #{@clue_return}")

    return_log
  end

  attr_accessor :combination

  def shuffle_deck
    temp_combination = @starter_deck.shuffle
    temp_combination.delete_at(rand(5))
    temp_combination.delete_at(rand(4))
    temp_combination
  end
end

new_game = Combo.new
new_game.start_game

puts 'Do you want to play again? (y/n)'
if gets.chomp == 'y'
  new_game = Combo.new
  new_game.start_game
end
