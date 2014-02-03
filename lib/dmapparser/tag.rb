module DMAPParser
  # The Tag class
  class Tag < Struct.new(:type, :value)
    def to_s
      "#<#{self.class.name} #{type}>"
    end

    def inspect(level = 0)
      "#{'  ' * level}#{type}: #{value}"
    end

    def to_dmap
      value = convert_value(self.value)
      length = [value.length].pack('N')
      (type.tag.to_s + length + value).force_encoding('utf-8')
    end

    private

    def convert_value(value)
      Converter.encode(type.type, value)
    end
  end
end
