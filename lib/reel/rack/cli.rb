require 'reel/rack'

module Reel
  module Rack
    class CLI
      def initialize(argv)
        @argv   = argv
        @rackup = "config.ru"
      end

      def run
        app, options = ::Rack::Builder.parse_file(@rackup)
        ::Rack::Handler::Reel.run(app, options)
      end
    end
  end
end