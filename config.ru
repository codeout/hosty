require 'hosty'

use Rack::ReverseProxy do
  Hosty::Hosts.mapping do |map|
    port = map[:port]
    scheme = map[:options].include?('tls') ? 'https' : 'http'

    proxy_options = {}
    proxy_options[:verify_mode] = OpenSSL::SSL::VERIFY_NONE if map[:options].include?('verify_none')


    map[:servers].each do |server|
      reverse_proxy /(.*)/, "#{scheme}://#{server}:#{port}$1", {vhost: server}.merge(proxy_options)
    end
  end
end

run proc {}
