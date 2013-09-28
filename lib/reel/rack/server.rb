# Adapted from code orinially Copyright (c) 2013 Jonathan Stott

require 'reel'
require 'rack'

module Reel
  module Rack
    class Server < Server
      include Celluloid::Logger

      attr_reader :app

      def initialize(app, options)
        raise ArgumentError, "no host given" unless options[:Host]
        raise ArgumentError, "no port given" unless options[:Port]

        info  "A Reel good HTTP server! (Codename \"#{::Reel::CODENAME}\")"
        info "Listening on http://#{options[:Host]}:#{options[:Port]}"

        super(options[:Host], options[:Port], &method(:on_connection))
        @app = app
      end
   
      def on_connection(connection)
        connection.each_request do |request|
          if request.websocket?
            request.respond :bad_request, "WebSockets not supported"
          else
            route_request request
          end
        end
      end
   
      def route_request(request)
        options = {
          :method       => request.method,
          :input        => request.body.to_s,
          "REMOTE_ADDR" => request.remote_addr
        }.merge(convert_headers(request.headers))
   
        status, headers, body = app.call ::Rack::MockRequest.env_for(request.url, options)

        if body.respond_to?(:to_str)
          request.respond status_symbol(status), headers, body.to_str
        elsif body.respond_to?(:each)
          request.respond status_symbol(status), headers.merge(:transfer_encoding => :chunked)
          body.each { |chunk| request << chunk }
          request.finish_response
        else
          Logger.error("don't know how to render: #{body.inspect}")
          request.respond :internal_server_error, "An error occurred processing your request"
        end

        body.close if body.respond_to? :close
      end
   
      def convert_headers(headers)
        Hash[headers.map { |key, value| ['HTTP_' + key.upcase.gsub('-','_'),value ] }]
      end
   
      def status_symbol(status)
        if status.is_a?(Fixnum)
          Http::Response::STATUS_CODES[status].downcase.gsub(/\s|-/, '_').to_sym
        else
          status.to_sym
        end
      end
    end
  end
end
