module Hosty
  module SchemeDetectable
    def url
      original = super

      if original[0..1] == '//'
        "#{env['rack.url_scheme']}:#{original}"
      else
        original
      end
    end
  end
end
