require_relative "00_tree_node"

class KnightPathFinder
    attr_accessor :considered_positions, :root_node
    attr_reader :start_pos, :build_move_tree

    MOVES = [
        [-2, -1],
        [-2,  1],
        [-1, -2],
        [-1,  2],
        [ 1, -2],
        [ 1,  2],
        [ 2, -1],
        [ 2,  1]
    ]

    def self.valid_moves(pos)
        new_moves = []
        x , y = pos
        MOVES.each do |(new_x, new_y)|
            new_pos = [x + new_x, y + new_y]
            if new_pos[0] >= 0 && new_pos[0] <= 7 && new_pos[1] >= 0 && new_pos[1] <= 7
                new_moves << new_pos
            end
        end
        new_moves
    end
    
    def initialize(start_pos)
        
        @start_pos = start_pos
        @considered_positions = [start_pos]

        # build_move_tree
    end

    def build_move_tree
        self.root_node = PolyTreeNode.new(start_pos)
        nodes = [root_node]
        until nodes.empty?
            current_node = nodes.shift
            current_pos = current_node.value
            new_move_positions(current_pos).each do |next_pos|
                next_node = PolyTreeNode.new(next_pos)
                current_node.add_child(next_node)
                nodes << next_node
            end
        end
    end

    def new_move_positions(pos)
        KnightPathFinder.valid_moves(pos)
            .reject {|new_pos| considered_positions.include?(new_pos)}
            .each {|new_pos| considered_positions << new_pos}
    end

    def find_path(end_pos)
        end_node = root_node.bfs(end_pos)

        trace_path_back(end_node)
    end

    def trace_path_back(end_pos)
        track = []
        
        current_node = end_pos
        until current_node.nil?
            track << current_node.value
            current_node = current_node.parent
        end
        track.reverse
    end
end