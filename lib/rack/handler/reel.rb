require 'reel/rack/server'

module Rack
  module Handler
    class Reel
      DEFAULT_OPTIONS = {
        :host    => "0.0.0.0",
        :port    => 3000,
        :quiet   => false
      }

      def self.run(app, options = {})
        options = DEFAULT_OPTIONS.merge(options)

        unless options[:quiet]
          app = Rack::CommonLogger.new(app, STDOUT)
        end

        if options[:environment]
          ENV['RACK_ENV'] = options[:environment].to_s
        end

        Celluloid.logger.info  "A Reel good HTTP server! (Codename \"#{::Reel::CODENAME}\")"
        Celluloid.logger.info "Listening on #{options[:host]}:#{options[:port]}"

        supervisor = ::Reel::Rack::Server.supervise_as(:reel_rack_server, app, options)

        begin
          sleep
        rescue Interrupt
          Celluloid.logger.info "Interrupt received... shutting down"
          supervisor.terminate
          Celluloid::Actor.join(supervisor)
          Celluloid.logger.info "That's all, folks!"
        end
      end
    end

    register :reel, Reel
  end
end
