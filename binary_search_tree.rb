class Node
    attr_accessor :data, :left, :right
    def initialize(data)
        @data = data
        @left = nil
        @right = nil
        
    end
end

class Tree
    attr_accessor :data, :root

    def initialize(array)
        @data = array.sort.uniq
        @root = buildTree(array)
    end

    def buildTree(array)
        if array.empty?
        return nil
        end
        middle = (array.size - 1)/2
        rootNode = Node.new(array[middle])
        rootNode.left = buildTree(array[0...middle])
        rootNode.right = buildTree(array[(middle+1)...])

    return rootNode
    end

    def insert(value, node = root)
        if node.data == value
            return nil
        end

        if value < node.data #recurse left
            if node.left.nil?
                node.left = Node.new(value)
            else
                insert(value, node.left)
            end
        end
        
        if value > node.data #recurse right
            if node.right.nil?
                node.right = Node.new(value)
            else
                insert(value,node.right)
            end
        end

    end

end

array = [1,2,3,4,5,6,7]
newtree = Tree.new(array)
newtree.buildTree(array)
newtree.insert(8)
pp newtree