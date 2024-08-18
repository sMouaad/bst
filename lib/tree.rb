require_relative 'node'
class Tree
  def initialize(arr)
    @root = build_tree(arr.uniq.sort)
  end

  def pretty_print(node = @root, prefix = '', is_left = true) # rubocop:disable Style/OptionalBooleanParameter
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def insert(value, node = @root)
    if node < value
      return node.right_child = Node.new(value) if leaf?(node)

      insert(value, node.right_child)
    elsif node > value
      return node.left_child = Node.new(value) if leaf?(node)

      insert(value, node.left_child)
    end
    nil
  end

  def delete(value, node = @root)
    return node if node.nil?

    if node < value
      node.right_child = delete(value, node.right_child)
    elsif node > value
      node.left_child = delete(value, node.left_child)
    else
      return node.right_child if node.left_child.nil?
      return node.left_child if node.right_child.nil?

      # When both children are present
      succ = get_successor(node)
      node.value = succ.value
      node.right_child = delete(node.right_child, succ.value)
    end
    node
  end

  def get_successor(node)
    node = node.right
    node = node.left_child until node.nil? || node.left_child.nil?
    node
  end

  def find(value, node = @root)
    return node if node.nil? || node == value

    if node < value
      find(value, node.right_child)
    else
      find(value, node.left_child)
    end
  end

  def leaf?(node)
    node.left_child.nil? && node.right_child.nil?
  end

  private

  def build_tree(arr)
    return nil if arr.empty?

    middle_index = arr.length / 2
    root = Node.new(arr[middle_index])
    root.left_child = build_tree((arr[0...(middle_index)]))
    root.right_child = build_tree((arr[middle_index + 1..]))
    root
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.pretty_print
tree.insert(6)
tree.pretty_print
tree.insert(68)
tree.pretty_print
tree.delete(68)
tree.pretty_print
