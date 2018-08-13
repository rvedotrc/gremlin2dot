module Gremlin2Dot

  class Unmangler

    def unmangle(d)
      if d.kind_of?(Hash) and d.has_key?('@type') and d.has_key?('@value') and d.keys.count == 2
        case d['@type']
        when 'g:Map'
          d['@value'].map {|t| unmangle t}.to_h
        when 'g:Set'
          d['@value'].map {|t| unmangle t}.to_set
        when 'g:List'
          unmangle d['@value']
        when 'g:Tree'
          # array of hashes, where each hash has 'key'=Vertex/Edge, 'value' = ...
          # Array of Hash with 'key' and 'value', where ...
          # – key is a Vertex
          # – value is a Hash of @type/@value

          d['@value'].map do |item|
            t = Tree.new
            t.key = unmangle item['key']
            t.items = unmangle item['value']
            t
          end
        when 'g:Path'
          unmangle_object(d, Path)
        when 'g:Edge'
          unmangle_object(d, Edge)
        when 'g:Vertex'
          unmangle_object(d, Vertex)
        when 'g:VertexProperty'
          unmangle_object(d, VertexProperty)
          # discard the id
          # unmangle d['@value']['value']
        when 'g:Property'
          unmangle_object(d, Property)
          # discard the key
          # unmangle d['@value']['value']
        when 'g:Int32', 'g:Int64', 'g:Double'
          d['@value']
        when 'g:Date'
          Time.at(d['@value'] / 1000.0)
        else
          $stderr.puts 'Ignoring unknown type ' + d['@type'] + " with value #{d['@value'].inspect[0..200]}..."
          unmangle d['@value']
        end
      elsif d.kind_of? Hash
        d.entries.map {|k, v| [k, unmangle(v)]}.to_h
      elsif d.kind_of? Array
        d.map {|v| unmangle v}
      else
        d
      end
    end

    def unmangle_object(d, klass)
      o = klass.new
      d['@value'].entries.each do |k, v|
        o[k] = unmangle v
      end
      o
    end

  end

end
