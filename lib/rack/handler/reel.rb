require 'celluloid/current'
require 'reel/rack/server'

module Rack
  module Handler
    class Reel
      DEFAULT_OPTIONS = {
        :Host    => "0.0.0.0",
        :Port    => 3000,
        :quiet   => false
      }

      def self.run(app, options = {})
        options = DEFAULT_OPTIONS.merge(options)

        app = Rack::CommonLogger.new(app, STDOUT) unless options[:quiet]
        ENV['RACK_ENV'] = options[:environment].to_s if options[:environment]

        supervisor = ::Reel::Rack::Server.supervise(as: :reel_rack_server, args: [app, options])

        begin
          sleep
        rescue Interrupt
          Celluloid.logger.info "Interrupt received... shutting down"
          supervisor.terminate
        end
      end
    end

    register :reel, Reel
  end
end
