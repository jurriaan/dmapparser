require 'dmapparser/tag_definitions'
require 'dmapparser/converter'
require 'stringio'

module DMAPParser
  # The DMAPParser class parses DMAP responses
  class Parser
    ParseError = Class.new(StandardError)

    def self.parse(response)
      new(response).parse
    end

    def initialize(response)
      @response = response
      @response = StringIO.new(response) unless @response.is_a? IO
      @response.set_encoding(Encoding::UTF_8) # Use unicode
    end

    def parse
      return nil if @response.nil? || @response.size == 0
      fail ParseError if @response.size < 8
      ret = TagContainer.new
      ret.type = TagDefinition[read_key]
      fail ParseError if ret.type && !ret.type.container?
      ret.value = parse_container(read_length)
      ret
    end

    private

    def bytes_left
      @response.size - @response.pos
    end

    def bytes_available?(num = 1)
      bytes_left - num >= 0
    end

    def read_bytes(length)
      unless bytes_available?(length)
        fail ParseError, 'Not enough data available'
      end
      @response.read(length)
    end

    def read_length
      Converter.bin_to_int(read_bytes(4))
    end

    def read_key
      read_bytes(4)
    end

    def parse_container(container_length)
      values = []
      end_pos = container_length + @response.pos
      values << build_tag(read_key, read_length) until @response.pos == end_pos
      values
    end

    def build_tag(key, length)
      tag = TagDefinition[key] ||
            TagDefinition.new(key, :unknown, "unknown (#{length})")
      if tag.container?
        TagContainer.new(tag, parse_container(length))
      else
        Tag.new(tag, Converter.decode(tag.type, read_bytes(length)))
      end
    end
  end
end
