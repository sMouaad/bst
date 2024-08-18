require_relative 'node'
class Tree
  def initialize(arr)
    @root = build_tree(arr.sort)
  end

  def pretty_print(node = @root, prefix = '', is_left = true) # rubocop:disable Style/OptionalBooleanParameter
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  private

  def build_tree(arr)
    return nil if arr.empty?

    middle_index = arr.length / 2
    root = Node.new(arr[middle_index])
    root.left_child = build_tree(p(arr[0...(middle_index)]))
    root.right_child = build_tree(p(arr[middle_index + 1..]))
    root
  end
end
