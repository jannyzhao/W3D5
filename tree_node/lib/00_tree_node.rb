require "byebug"
class PolyTreeNode
    attr_reader :value, :children
    attr_accessor :parent
    def initialize(value)
        @value = value
        @parent = nil
        @children = [] 
    end
    
    def parent=(new_parent)
        
        # if parent is nil (empty)
        # @parent = new_parent
        # go into new_parent and add self ONLY IF new_parent is not nil

        unless @parent == nil # when parent is not nil # if self has a parent
            @parent.children.delete(self) # [node1, node2] # go into parent and look at list of children and remove myself frm list

        end

        @parent = new_parent # changing my self (change new parent)
        unless new_parent == nil # if actual node
            @parent.children << self  # add myself as their children
        end
    end

    def add_child(new_child)
        new_child.parent = self
    end

    def remove_child(child)
        if self.children.include?(child)    
            child.parent = nil
            self.children.delete(child)
        else
            raise "not a child"
        end
    end

    def inspect
		"<Node: #{object_id}, children: #{children.map {|child| child.value}}>"
	end

    def dfs(target)
        stack = MyStack.new
        stack.push(self)

        until stack.empty?
            curr_node = stack.pop
            # debugger
                if curr_node.value == target
                    return curr_node
                end
                curr_node.children.each do |child|
                    attempt = child.dfs(target)
                    return attempt if attempt
                end
        end
        nil
    end

    def bfs(target)
        queue =  MyQueue.new # Array
        queue.enqueue(self)

		until queue.empty?
			curr_node = queue.dequeue #where it removes from the queue
				if curr_node.value == target
					return curr_node
				end
				curr_node.children.each do |child|
					queue.enqueue(child)
				end
            
        end
        nil
    end

end

class MyStack

	def initialize
		@store = []
	end

	def push(value)
		@store.push(value)
	end

	def pop
		@store.pop
	end

	def peek
		@store[0]
	end

	def size
		@store.length
	end

	def empty?
		@store.empty?
	end

end

class MyQueue
	def initialize
		@store = []
	end

	def enqueue(el)
		@store.unshift(el) #store.push(el)
	end

	def dequeue
		@store.pop #store.shift
	end

	def show
		@store.dup 
	end

	def empty?
		@store.empty?
	end

	def size
		@store.length
	end
end