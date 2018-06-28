require 'set'

module Gremlin2Dot

  class GraphBuilder

    def self.build(results)
      self.new().build(results)
    end

    def initialize
      @seen = Set.new
      @g = GraphViz.new("G")
    end

    def build(unmangled_data)
      trees = unmangled_data['result']['data']

      trees.each do |t0|
        t0.each do |t1|
          add_thing t1
        end
      end

      @g
    end

    def add_thing(thing)
      case thing
      when Vertex
        node = thing
        unless @seen.include? node.id
          label = node.label + node.properties.entries.sort_by(&:first).map {|k, v| "\n#{k}=#{v.first}" }.join("")
          @g.add_nodes(node.id, label: label)
          @seen << node.id
        end
      when Edge
        edge = thing
        unless @seen.include? edge.id
          label = edge.label + edge.properties.entries.sort_by(&:first).map {|k, v| "\n#{k}=#{v}" }.join("")
          @g.add_edges(edge.outV, edge.inV, label: label)
          @seen << edge.id
        end
      when Tree
        add_thing thing.key
        thing.items.each {|child| add_thing child}
      else
        $stderr.puts "Not adding #{thing.class} to the graph"
      end
    end

  end

end
