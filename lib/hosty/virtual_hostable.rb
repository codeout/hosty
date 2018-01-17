module Hosty
  module VirtualHostable
    def proxy
      debug "<= #{env['REQUEST_METHOD']} #{source_request.url}"

      return app.call(env) if uri.nil?
      return https_redirect if need_https_redirect?

      setup_request
      setup_response_headers

      debug "  -> #{env['REQUEST_METHOD']} #{uri}"

      transform_response(rack_response).tap {|t|
        debug "  <- #{t[0]}"
      }
    end

    def rules
      super.select {|r| r.options[:vhost] == env['SERVER_NAME'] }
    end


    private

    def debug(message)
      puts "#{Time.now} #{message}" if $HOSTY_DEBUG
    end
  end
end
