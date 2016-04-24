require 'hosty'

use Rack::ReverseProxy do
  Hosty::Hosts.mapping do |map|
    port = map[:port]

    map[:servers].each do |server|
      reverse_proxy /(.*)/, "//#{server}:#{port}/$1", vhost: server
    end
  end
end

run proc {}
