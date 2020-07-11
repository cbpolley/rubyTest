string = 'B'

conclusion = case string
    when 'A' 
        puts 'a time'
        puts 'great job'
    when 'B' 
        puts 'b time'
    when 'C' 
        puts 'c time'
    else 'no no'
end

i = 0

response = string == 'A' ? 'it is A' : 'it is not A'

loop do
    puts response + 'for'
    i += 1
    break if i == 10
end

i = 0

while i < 10 do
    puts response + 'while'
    i += 1
end

i = 0

until i > 10 do
    puts response + 'until'
    i += 1
end

numberRange = (1..10)

for i in numberRange
    puts "#{i} number of things"
end

repeat = 5

repeat.times do |repeat|
    puts "repeating #{repeat} number of times"
end

helloArr =  Array.new(3, "hello") #creates new array of 3 elements with a default value of hello

puts helloArr

i = 0

while i < 4 do 
    helloArr << "hello#{i}" 
    i += 1
end

puts helloArr

person = {height: '6 foot', weight: '90kgs'}

puts person[:weight]

friends = ['a', 'b', 'c', 'd', 'e']

friends.each { |friend| puts 'hello, ' + friend }

friends.each { |friend| puts 'hello, ' + friend }

hashy = Hash.new(0)

puts hashy

def greet(name = "Stranger")
    return "Hello, " + name + "!"
end

puts greet()

def double_words_in_String(string)
    string_array = string.split(' ')
    output_array = string_array.map { |word| word * 2}
    return output_array.join(' ')
end 

puts double_words_in_String("This is a test")