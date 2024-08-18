class Node
  include Comparable
  attr_accessor :data, :left_child, :right_child

  def initialize(data)
    @data = data
    @left_child = nil
    @right_child = nil
  end

  def <=>(other)
    return data <=> other if other.is_a? Numeric

    data <=> other.data
  end

  def leaf?
    left_child.nil? && right_child.nil?
  end
end
