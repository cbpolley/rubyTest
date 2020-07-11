puts 'What string would you like to encrypt?'
user_text = gets.chomp.to_s

puts 'shift by how many letters?'
user_shift = gets.chomp.to_i

def ceasar(input_text, shift)
    output_string = ""
    input_text.split("").map do |letter|
        if letter.ord > 65 && letter.ord < 91
            letter = ((letter.ord - 64 + shift) % 26) + 64
        elsif letter.ord > 96 && letter.ord < 123
            letter = ((letter.ord - 96 + shift) % 26) + 96
        else 
            letter = letter.ord
        end
        output_string += letter.chr
    end
    puts output_string
end

ceasar(user_text, user_shift)
