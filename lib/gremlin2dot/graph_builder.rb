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
      add_thing unmangled_data['result']['data']
      @g
    end

    private

    def add_thing(thing)
      # $stderr.puts "add_thing #{thing.class} #{thing}"
      case thing
      when Vertex
        once_only(thing.id) { add_node thing }
      when Edge
        once_only(thing.id) { add_edge thing }
      when Tree
        add_thing thing.key
        thing.items.each {|child| add_thing child}
      when Array
        thing.each {|child| add_thing child}
      else
        $stderr.puts "Not adding #{thing.class} to the graph"
      end
    end

    def once_only(id)
      unless @seen.include? id
        yield
        @seen << id
      end
    end

    def add_node(node)
      label = node.id + "\n" + node.label + node.properties.entries.sort_by(&:first).map {|k, v| "\n#{k}=#{v.first}" }.join("")
      @g.add_nodes(node.id, label: label)
    end

    def add_edge(edge)
      label = edge.id + "\n" + edge.label + edge.properties.entries.sort_by(&:first).map {|k, v| "\n#{k}=#{v}" }.join("")
      @g.add_edges(edge.outV, edge.inV, label: label)
    end

  end

end
