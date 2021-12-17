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

    def delete(value, node = root)
        if node.nil?
            return node
        elsif value < node.data
            node.left =  delete(value, node.left)
        elsif value > node.data
            node.right = delete(value, node.right)
        else #found node with matching value
            
            if (node.left.nil? && node.right.nil?) #if no child
                node = nil
            elsif node.left.nil? #if 1 right child
                node = node.right
            elsif node.right.nil? #if 1 left child
                node = node.left
            else                  #if 2 childs
                node.data = findmin(node.right)
                node.right = delete(node.data, node.right)
            end
        end
        return node
    end

    def findmin(node)
        min = node
        until node.left.nil?
            min = node.left
        end
        return min.data
    end

end

array = [1,2,3,4,5,6,7]
tree = Tree.new(array)
tree.buildTree(array)
pp tree
tree.delete(3)
pp tree
