#basic node class
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
        sorted = array.sort.uniq
        @root = buildTree(sorted)
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

    def delete(value, node = @root, parent = nil)
        
        if node.nil?
            return node
        elsif value < node.data
            parent = node    
            node.left =  delete(value, node.left, parent)
        elsif value > node.data
            parent = node
            node.right = delete(value, node.right, parent)
        else #found node with matching value
            if node.right.nil? && node.right.nil? # no children
                if parent.right.nil?
                   return parent.left = nil
                else
                    return parent.right = nil
                end
            elsif node.left.nil? #if 1 right child
                return parent.right = node.right    
            elsif node.right.nil? #if 1 left child
                return parent.left = node.left
            else                  #if 2 children
                node.data = findmin(node.right)
                node.right = delete(node.data, node.right, parent)
            end
        end
        return node
    end

    def find(value, node = root)
        if node.nil? || node.data == value
            return node
        else
            if value < node.data
                find(value, node.left)
            end
            if value > node.data
                find(value, node.right)
            end
        end
    end

    def level_order(node = @root, &block)
        queue = [node]
        result = []
        until queue.empty?
            node = queue.shift
            if block_given? # appropriate work on each node if block given, else data stored to result array
                yield (node)
            else
                result << node.data
            end
            queue << node.left unless node.left.nil?
            queue << node.right unless node.right.nil?
        end
        result unless block_given? #result array returned if no block provided
    end

    def in_order(node = @root)
        
        result = []
        in_order_recurse(node, result)
        return result
        
    end

    def preorder(node = @root)

        result = []
        preorder_recurse(node, result)
        return result
        
    end

    def postorder(node = @root)

        result = []
        postorder_recurse(node,result)
        return result
        
    end

    def height(node = @root)
        if node == nil
            return -1
        else
            leftHeight = height(node.left)
            rightHeight = height(node.right)
            return [leftHeight,rightHeight].max+1
        end
    end

    def depth(node = @root,base = @root, depth = 0)
        if node == base
            return 0
        end

        if node == nil
            return -1
        end

        if node.data < base.data
            depth +=1
            depth(node.left,base,depth)
        elsif node.data > base.data
            depth +=1
            depth(node.right,base,depth)
        else
            depth
        end

    end

    def balanced?(root = @root)
        leftsubtree = height(root.left)
        rightsubtree = height(root.right)

        if (leftsubtree - rightsubtree).abs > 1
            return false
        else
            return true
        end
    end

    def rebalance
        @root = buildTree(in_order)
    end
    ###from assigment
    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end


    #########################################
    #helper function
    private

    def findmin(node) #returns minimum value from a given node
        min = node
        until node.left.nil?
            min = node.left
        end
        return min.data
    end

    def in_order_recurse(node, result)
        
        if node == nil
            return 
        end

        in_order_recurse(node.left,result)
        block_given? ? yield(node) : result << node.data
        in_order_recurse(node.right, result)
        
    end

    def preorder_recurse(node,result)
        if node == nil
            return
        end

        block_given? ? yield(node) : result << node.data
        preorder_recurse(node.left,result)
        preorder_recurse(node.right,result)
    end

    def postorder_recurse(node,result)
        if node == nil
            return
        end
        
        postorder_recurse(node.left,result)
        postorder_recurse(node.right,result)
        block_given? ? yield(node) : result << node.data
        
    end
    

    

end

tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print
puts 'new tree'
p tree.balanced?
puts 'orders'
p tree.level_order
p tree.preorder
p tree.postorder
p tree.in_order
tree.insert(115)
tree.insert(75)
tree.insert(110)
tree.insert(135)
tree.insert(167)
tree.insert(174)
tree.pretty_print
tree.delete(174)  
tree.pretty_print
p tree.balanced?
tree.rebalance
p tree.balanced?
puts 'orders'
p tree.level_order
p tree.preorder
p tree.postorder
p tree.in_order
