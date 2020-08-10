# sets up a new root node
class Node
  attr_accessor :value
  attr_accessor :children
  attr_accessor :parent

  def initialize(coord, parent = nil)
    @value = coord
    @parent = parent
    @children = []
  end
end

# sets up a new board and counts moves
class Board
  def initialize(root = [])
    @board = root
  end
  # generates a list of all potential moves a knight can make.
  def create_list(root)
    move_list = []
    move_list.push(Node.new([root.value[0] - 2, root.value[1] - 1], root))
    move_list.push(Node.new([root.value[0] - 2, root.value[1] + 1], root))
    move_list.push(Node.new([root.value[0] + 2, root.value[1] - 1], root))
    move_list.push(Node.new([root.value[0] + 2, root.value[1] + 1], root))
    move_list.push(Node.new([root.value[0] - 1, root.value[1] - 2], root))
    move_list.push(Node.new([root.value[0] - 1, root.value[1] + 2], root))
    move_list.push(Node.new([root.value[0] + 1, root.value[1] - 2], root))
    move_list.push(Node.new([root.value[0] + 1, root.value[1] + 2], root))

    move_list
  end
  # takes the start co-ordinates (i.e. 4,4), uses breadth first searching to search through all children for the end point.

  def knight_moves(start_point, end_point)
    root = Node.new start_point
    node_list = [root]
    found_target = ''
    moves = []
    new_nodes = []
    until moves.include?(end_point)
      # if the end point isn't found, search the childrens children, etc.
      node_list.each do |node|
        next if @board.include?(node.value)
        next if node.value.any? { |i| i < 1 && i > 8 }

        moves.push(node.value)
        found_target = node if node.value == end_point
        @board.push(node.value)
        new_nodes += create_list(node)
      end
      node_list = new_nodes
      new_nodes = []
    end
    node_list = []
    until found_target.parent.nil?
      node_list.unshift(found_target.value)
      found_target = found_target.parent
    end
    node_list.unshift(root.value)
    print "You made it in #{node_list.length} moves! Here's your path: \n"
    node_list.each do |node|
      print "\n#{node}"
    end
    draw_board(node_list)
  end
  # draw a representation of the knights movements on a 'chess board'
  def draw_board(move_str)
    b = 0
    puts "\n\nThe Knights Travails :\n\n"
    8.downto 1 do |i|
      board_arr = []
      1.upto 8 do |a|
        if move_str.include?([i, a])
          b = move_str.index([i, a]) + 1
          b < 10 ? board_arr.push("[ #{b}]") : board_arr.push("[#{b}]")
        else
          board_arr.push('[  ]')
        end
      end
      print "#{i} #{board_arr.join}\n"
    end
    print "    1   2   3   4   5   6   7   8 \n\n"
  end
end

new_game = Board.new
new_game.knight_moves([4, 4], [8, 8])
