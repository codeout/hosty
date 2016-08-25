require 'hosty/hosts'
require 'hosty/virtual_hostable'
require 'rack/reverse_proxy'

RackReverseProxy::RoundTrip.prepend Hosty::VirtualHostable
