class Node
    attr_accessor data:, :left, :right
    def initialize(data)
        @data = data
        @left = nil
        @right = nil
        
    end
end

class Tree
    attr_accessor data:, root:

    def initialize(array)
        @data = array.sort.uniq
        @root = buildTree(data)
    end

def buildTree(array)
    if array.empty?
        return nil
    
    middle = (array.size - 1)/2
    rootNode = Node.new(array[middle])
    rootNode.left = buildTree(array[0...middle])
    rootNode.right = buildTree(array[(middle+1)...])

    return rootNode
end

end