require 'byebug'
class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def parent=(parent)
    return if self.parent == parent
    @parent.children.delete(self) if @parent != nil
    @parent = parent

    @parent.children << self unless parent.nil?

  end

  def children
    @children
  end

  def value
    @value
  end

  def add_child(child_node)
    child_node.parent=(self)
  end

  def remove_child(child_node)
    child_node.parent=(nil)
    raise "Bad parent" if child_node.parent != self
  end

  def dfs(target_value)
    return self if self.value == target_value

    children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end

    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      shifted = queue.shift
      if shifted.value == target_value
        return shifted
      else
        queue += shifted.children
      end
    end
    nil
  end
end
