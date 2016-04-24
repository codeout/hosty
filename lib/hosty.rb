require 'hosty/hosts'
require 'hosty/scheme_detectable'
require 'hosty/virtual_hostable'
require 'rack/reverse_proxy'

RackReverseProxy::RoundTrip.prepend Hosty::VirtualHostable
RackReverseProxy::Rule::Candidate.prepend Hosty::SchemeDetectable
