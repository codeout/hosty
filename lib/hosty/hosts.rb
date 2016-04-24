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
        content(str).each_line do |l|
          columns = l.split
          next unless columns[0].local_address?

          if columns.last.port_number?
            yield servers: columns[1..-2], port: columns.last.port_number
          end
        end
      end

      def content(raw)
        raw.skip_comment_lines.shorten_port_definitions
      end
    end
  end
end
