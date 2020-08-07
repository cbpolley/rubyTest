# create and setup new node for insertion in the tree
class Node
  attr_reader :data
  attr_accessor :left
  attr_accessor :right

  def initialize(data = nil)
    @data = data
    @left = nil
    @right = nil
  end
end

# controls left and right assignments to each node in the tree
class Tree
  attr_reader :root

  def initialize(array = nil)
    @array = remove_duplicates(array)
    @array = merge_sort(@array)
    print @array
    @array_start = 0
    @array_end = @array.length - 1
    @root = build_tree(@array)
  end

  def merge_sort(num_array)
    return num_array if num_array.length <= 1

    half = (num_array.length / 2)
    left_array = merge_sort(num_array[0..half - 1])
    right_array = merge_sort(num_array[half..num_array.length - 1])
    merge(left_array, right_array)
  end

  def merge(left_array, right_array)
    return left_array if right_array == []
    return right_array if left_array == []

    return_array = []
    if left_array[0] < right_array[0]
      return_array.push(left_array[0]) + merge(left_array[1..left_array.length], right_array)
    else
      return_array.push(right_array[0]) + merge(right_array[1..right_array.length], left_array)
    end
  end

  def remove_duplicates(array)
    array.each do |i|
      array.slice!(i - 1, 1) if array.count(i) > 1
    end
  end

  def build_tree(array)
    mid = (array.length / 2)
    root = Node.new(array[mid])
    return root if array.length < 2

    root.left = build_tree(array[0..mid - 1])
    root.right = build_tree(array[mid + 1..array.length - 1])
    pretty_print(root)
  end

  def pretty_print(node = root, prefix="", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? "│ " : " "}", false) if node.right
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
    pretty_print(node.left, "#{prefix}#{is_left ? " " : "│ "}", true) if node.left
  end
end

Tree.new [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
