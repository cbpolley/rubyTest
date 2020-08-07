class LinkedList
  attr_reader :size
  def initialize(value = nil)
    @head = Node.new
    @head.value = value
    @tail = @head
    @size = 1
  end

  def append(value)
    if @head.value.nil?
      initialize value
    else
      append_node = Node.new
      append_node.value = value
      @tail.next_node = append_node
      @tail = append_node
    end
    @size += 1
  end

  def prepend(value)
    if @head.value.nil?
      initialize value
    else
      append_node = Node.new
      append_node.value = value
      append_node.next_node = @head
      @head = append_node
    end
    @size += 1
  end

  def head
    @head.value
  end

  def tail
    @tail.value
  end

  def at(index)
    return @head if index < 2

    index_find = @head
    str = ''
    (index - 1).times do |i|
      index_find = index_find.next_node if index_find.next_node.nil? == false
      str = i == index && index_find == @head ? 'index too high' : index_find.value
    end
    str
  end

  def pop
    pop_find = @head
    pop_find = pop_find.next_node until pop_find.next_node == @tail
    @tail = pop_find
    pop_find.next_node = nil
    @size -= 1
  end

  def contains?(value)
    contain_find = @head
    while contain_find.value != value
      return 'false' if contain_find.next_node.nil?

      contain_find = contain_find.next_node
    end
    contain_find.value == value
  end

  def find(value)
    find_index = @head
    index = 1
    until find_index.next_node.nil? || find_index.value == value
      find_index = find_index.next_node
      index += 1
    end
    find_index.value == value ? value : 'nil'
  end

  def to_s
    iterate = @head
    str = "( #{iterate.value} )"
    loop do
      iterate = iterate.next_node
      str += " -> ( #{iterate.value} )"
      if iterate.next_node.nil?
        str += ' -> nil'
        break
      end
    end
    str
  end

  def insert_at(value, index)
    if index < 2
      prepend(value)
    else
      insert = @head
      (index - 2).times do
        if insert.next_node.nil?
          append(value)
          return
        end
        insert = insert.next_node
      end
      new_node = Node.new value
      new_node.next_node = insert.next_node
      insert.next_node = new_node
    end
  end

  def remove_at(index)
    if index < 2
      @head = @head.next_node
    else
      insert = @head
      (index - 2).times do
        insert = insert.next_node
      end
      temp = insert.next_node
      insert.next_node = temp.next_node
    end
  end
end

# class to create a new node. Node is added into linkedlist class.
class Node
  attr_accessor :value
  attr_accessor :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

# demonstrating that the methods work...

new_list = LinkedList.new(12)
new_list.append(13)
new_list.append(18)
new_list.prepend(9)
puts "list : #{new_list.to_s}"
puts "head : #{new_list.head}"
puts "tail : #{new_list.tail}"
puts "size : #{new_list.size}"
puts "index at 2 : #{new_list.at(2)}"
new_list.pop
puts "pop list : #{new_list.to_s}"
puts "list contains 13? : #{new_list.contains?(13)}"
puts "list contains 10? : #{new_list.contains?(10)}"
puts "find 12? : #{new_list.find(12)}"
puts "find 16? : #{new_list.find(16)}"
new_list.insert_at(46, 2)
puts "insert 46 at index 2 : #{new_list.to_s}"
new_list.remove_at(3)
puts "remove index 3 : #{new_list.to_s}"
