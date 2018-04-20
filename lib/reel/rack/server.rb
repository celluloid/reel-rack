# Adapted from code orinially Copyright (c) 2013 Jonathan Stott

require 'reel'
require 'reel/rack/handler'

module Reel
  module Rack
    class Server < Reel::Server::HTTP
      include Celluloid::Internals::Logger

      def initialize(app, options)
        raise ArgumentError, "no host given" unless options[:Host]
        raise ArgumentError, "no port given" unless options[:Port]

        info  "A Reel good HTTP server! (Codename \"#{::Reel::CODENAME}\")"
        info "Listening on http://#{options[:Host]}:#{options[:Port]}"

        if options[:Async]
          super(options[:Host], options[:Port]) do |connection|
            connection.detach
            Reel::Rack::Handler.on_connection(app, connection)
          end
        else
          handler = Reel::Rack::Handler.new(app)
          super(options[:Host], options[:Port]) do |connection|
            handler.on_connection(connection)
          end
        end
      end
    end
  end
end
