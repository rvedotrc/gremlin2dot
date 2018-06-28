module Gremlin2Dot

  class Edge < Hash
    def id ; self['id'] ; end
    def label ; self['label'] ; end
    def inVLabel ; self['inVLabel'] ; end
    def outVLabel ; self['outVLabel'] ; end
    def inV ; self['inV'] ; end
    def outV ; self['outV'] ; end
    def properties ; self['properties'] || {} ; end
    def inspect ; "#<#{self.class.name} #{super}>" ; end
  end

  class Vertex < Hash
    def id ; self['id'] ; end
    def label ; self['label'] ; end
    def properties ; self['properties'] || {} ; end
    def inspect ; "#<#{self.class.name} #{super}>" ; end
  end

  class VertexProperty < Hash
    def id ; self['id'] ; end
    def label ; self['label'] ; end
    def value ; self['value'] ; end

    def inspect
      value.inspect
    end

    def to_s
      value.to_s
    end

    def pretty_print(*args)
      value.pretty_print *args
    end
  end

  class Property < Hash
    def key ; self['key'] ; end
    def value ; self['value'] ; end

    def inspect
      value.inspect
    end

    def to_s
      value.to_s
    end

    def pretty_print(*args)
      value.pretty_print *args
    end
  end

  class Tree
    attr_accessor :key, :items
  end

end
