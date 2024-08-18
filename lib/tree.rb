require_relative 'node'
class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr.uniq.sort)
  end

  def pretty_print(node = root, prefix = '', is_left = true) # rubocop:disable Style/OptionalBooleanParameter
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def insert(value, node = root)
    if node < value
      return node.right_child = Node.new(value) if node.leaf?

      insert(value, node.right_child)
    elsif node > value
      return node.left_child = Node.new(value) if node.leaf?

      insert(value, node.left_child)
    end
    nil
  end

  def delete(value, node = root)
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
      node.data = succ.data
      node.right_child = delete(node.right_child, succ.value)
    end
    node
  end

  def get_successor(node)
    node = node.right
    node = node.left_child until node.nil? || node.left_child.nil?
    node
  end

  def find(value, node = root)
    return node if node.nil? || node == value

    if node < value
      find(value, node.right_child)
    else
      find(value, node.left_child)
    end
  end

  def level_order(arr = [root], result = [], &block)
    return nil if arr.empty?

    node = arr.shift
    result << node
    arr << node.left_child unless node.left_child.nil?
    arr << node.right_child unless node.right_child.nil?
    level_order(arr, result)
    level_order(arr, result)
    result.each(&block) if block
    result.map(&:data)
  end

  def preorder(node = root, result = [], &block)
    return nil if node.nil?

    result << node
    preorder(node.left_child, result)
    preorder(node.right_child, result)
    result.each(&block) if block
    result.map(&:data)
  end

  def inorder(node = root, result = [], &block)
    return nil if node.nil?

    inorder(node.left_child, result)
    result << node
    inorder(node.right_child, result)
    result.each(&block) if block
    result.map(&:data)
  end

  def postorder(node = root, result = [], &block)
    return nil if node.nil?

    postorder(node.left_child, result)
    postorder(node.right_child, result)
    result << node
    result.each(&block) if block
    result.map(&:data)
  end

  def height(node = root)
    return 0 if node.nil?
    return 1 if node.leaf?

    right_height = 1 + height(node.right_child)
    left_height = 1 + height(node.left_child)
    [right_height, left_height].max
  end

  def depth(node, pointer = root)
    return 0 if pointer.nil? || pointer == node

    return 1 + depth(node, pointer.left_child) if node < pointer

    1 + depth(node, pointer.right_child)
  end

  def balanced?(node = root)
    return true if node.nil?

    return false if (height(node.left_child) - height(node.right_child)).abs > 1

    left_balanced = balanced?(node.left_child)
    right_balanced = balanced?(node.right_child)

    true if left_balanced && right_balanced
  end

  def rebalance
    @root = build_tree(inorder)
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
