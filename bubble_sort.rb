def bubble_sort(number_array)
  # declare variables
  i = 0
  finish = true
  k = 1
  # iterate through each number and compare it against the number in front
  until i == number_array.length - k
    # if the current number is greater than the number in front,
    # remove the number in front into a temporary variable,
    # delete the number in front,
    # and add it back in behind the current number
    if number_array[i] > number_array[i + 1]
      temp_holder = number_array[i + 1]
      number_array.delete_at(i + 1)
      number_array.insert(i, temp_holder)
      finish = false
    end
    # count to iterate through the array
    i += 1
    # if we get to the end of the array and the finish variable hasn't changed, then end the loop.
    # otherwise, reduce the maximum iterations by 1 and go back to the start of the loop (because the last number in the loop will be sorted)
    if i == number_array.length - k && finish == false
      finish = true
      k += 1
      i = 0
    end
  end
  #return the final,updated array
  return number_array
end

p bubble_sort([4,3,78,2,0,2])