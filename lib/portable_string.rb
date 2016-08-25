module PortableString
  refine String do
    def local_address?
      self == '127.0.0.1' || self == '::1'
    end

    def port_number?
      port_number != nil
    end

    def port_number
      if self =~ /^:(\d+)$/
        $1.to_i
      end
    end
  end
end
