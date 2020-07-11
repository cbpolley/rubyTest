def stock_picker(number_array)
  #declare variables.
  max_profit = 0
  index_day = 0
  first_number = 0
  #loop through the number_array, comparing the difference between all numbers until we find the highest difference (a.k.a. profit).
  number_array.each_with_index do |valuemin, indexmin|
    min = valuemin
    number_array.each_with_index do |value, index|
      profit = value - min
      #save the highest profit amount, and the relative indexes of the first and second numbers that we compared.
        if index > indexmin && profit > max_profit
          first_number = indexmin
          max_profit = profit
          index_day = index
        end
    end
  end
  #puts the discovered information back to the user.
  puts "For a maximum profit of #{max_profit}..."
  puts "Buy for #{number_array[first_number]} on day #{first_number}"
  puts "Sell for #{number_array[index_day]} on day #{index_day}"
end

stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])