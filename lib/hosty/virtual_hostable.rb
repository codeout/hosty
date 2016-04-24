module Hosty
  module VirtualHostable
    def rules
      super.select {|r| r.options[:vhost] == env['SERVER_NAME'] }
    end
  end
end
