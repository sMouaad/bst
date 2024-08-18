# frozen_string_literal: true

require_relative 'lib/tree'

tree = Tree.new((1..9).to_a)
tree.pretty_print
p(tree.level_order { |node| p node.data })
p(tree.inorder { |node| p node.data })
p(tree.preorder { |node| p node.data })
p(tree.postorder { |node| p node.data })
p tree.height
p tree.balanced?
tree.insert(10)
tree.insert(11)
tree.insert(12)
tree.pretty_print
p tree.height
p tree.depth(tree.root.left_child.right_child)
p tree.balanced?
tree.rebalance
tree.pretty_print
p tree.balanced?
