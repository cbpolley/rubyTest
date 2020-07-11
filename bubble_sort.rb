def bubble_sort(number_array)
  i = 0
  finish = true
  k = 1

  until i == number_array.length - k
    if number_array[i] > number_array[i + 1]
      temp_holder = number_array[i + 1]
      number_array.delete_at(i + 1)
      number_array.insert(i, temp_holder)
      finish = false
    end
    i += 1
    if i == number_array.length - k && finish == false
      finish = true
      k += 1
      i = 0
    end
  end
  return number_array
end

p bubble_sort([4,3,78,2,0,2])