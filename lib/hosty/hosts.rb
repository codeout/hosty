require 'portable_string'

module Hosty
  class Hosts
    using PortableString

    class << self
      def mapping(&block)
        parse File.read('/etc/hosts'), &block
      end


      private

      def parse(str, &block)
        str.each_line {|l| new(l).parse &block }
      end
    end


    def initialize(line)
      @line = line
    end

    def parse(&block)
      return unless content
      yield content
    end


    private

    def content
      return @content if @content

      columns = @line.split
      return unless columns[0].local_address?

      mark_index = columns.index('#')
      return unless mark_index
      return unless columns[mark_index+1] && columns[mark_index+1].port_number?

      @content = {servers: columns[1..mark_index-1],
                  port: columns[mark_index+1].port_number,
                  options: columns[mark_index+2..-1]}
    end
  end
end
