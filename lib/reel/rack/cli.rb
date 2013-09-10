require 'reel/rack'
require 'optparse'

module Reel
  module Rack
    class CLI
      def initialize(argv)
        @argv   = argv
        @options = {
          addr:   "localhost",
          port:   3000,
          quiet:  false,
          rackup: "config.ru"
        }
        parser
      end

      def parser
        @parser ||= OptionParser.new do |o|
          o.banner = "reel-rack <options> <rackup file>"

          o.on "-a", "--addr ADDR", "Address to listen on (default #{@options[:addr]})" do |addr|
            @options[:addr] = addr
          end

          o.on "-p", "--port PORT", "Port to bind to (default #{@options[:port]})" do |port|
            @options[:port] = port
          end

          o.on "-q", "--quiet", "Suppress normal logging output" do
            @options[:quiet] = true
          end

          o.on_tail "-h", "--help", "Show help" do
            STDOUT.puts @parser
            exit 1
          end
        end
      end

      def run
        @parser.parse! @argv
        @options[:rackup] = @argv.shift if @argv.last

        app, options = ::Rack::Builder.parse_file(@options[:rackup])
        options.merge!(@options)
        ::Rack::Handler::Reel.run(app, options)
      end
    end
  end
end