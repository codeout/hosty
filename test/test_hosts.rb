require 'helper'

class TestHosts < Test::Unit::TestCase
  test 'load nothing for hosty' do
    hosts = <<-EOS
      127.0.0.1 a b c
      127.0.0.1 a b c  # 80
      127.0.0.1 a b c  # 80 :80
      192.168.0.1 a b  # :80
    EOS

    maps = []
    Hosty::Hosts.send(:parse, hosts) do |map|
      maps << map
    end
    assert_equal [], maps
  end

  test 'load non-aliased lines' do
    hosts = <<-EOS
      127.0.0.1 foo.example.com  # :8080
      127.0.0.1 bar.example.com  # :80 opt
      127.0.0.1 bar.example.com  # :80 opt1 opt2
    EOS
    expected = [
      {servers: ['foo.example.com'], port: 8080, options: []},
      {servers: ['bar.example.com'], port: 80, options: ['opt']},
      {servers: ['bar.example.com'], port: 80, options: ['opt1', 'opt2']}
    ]

    maps = []
    Hosty::Hosts.send(:parse, hosts) do |map|
      maps << map
    end
    assert_equal expected, maps
  end

  test 'load aliased lines' do
    hosts = <<-EOS
      127.0.0.1 foo.example.com foo1       # :8080
      127.0.0.1 bar.example.com bar1 bar2  # :80 opt
      127.0.0.1 bar.example.com bar1 bar2  # :80 opt1 opt2
    EOS
    expected = [
      {servers: ['foo.example.com', 'foo1'], port: 8080, options: []},
      {servers: ['bar.example.com', 'bar1', 'bar2'], port: 80, options: ['opt']},
      {servers: ['bar.example.com', 'bar1', 'bar2'], port: 80, options: ['opt1', 'opt2']}
    ]

    maps = []
    Hosty::Hosts.send(:parse, hosts) do |map|
      maps << map
    end
    assert_equal expected, maps
  end

  test 'skip blank lines' do
    hosts = <<-EOS

      127.0.0.1 foo.example.com foo1       # :8080
    EOS
    expected = [
      {servers: ['foo.example.com', 'foo1'], port: 8080, options: []}
    ]

    maps = []
    Hosty::Hosts.send(:parse, hosts) do |map|
      maps << map
    end
    assert_equal expected, maps
  end
end
