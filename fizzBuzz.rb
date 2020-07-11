fizz = "Fizz"
buzz = "Buzz"

puts 'What number do you want to fizzBuzz up to?'

user_number = gets.chomp.to_i

1.upto(user_number) do |current_number|
    
    if current_number % 3 == 0
        if current_number % 5 == 0
            puts fizz + buzz
        else
            puts fizz
        end
    elsif current_number % 5 == 0
        puts buzz
    else
        puts current_number
    end

end
