require 'reel/rack/server'
require 'net/http'

describe Reel::Rack::Server do
  let(:host) { "127.0.0.1" }
  let(:port) { 30000 }
  let(:body) { "hello world" }

  subject do
    app = proc { [200, {"Content-Type" => "text/plain"}, body] }
    described_class.new(app, :host => host, :port => port)
  end

  it "runs a basic Hello World app" do
    # Hax to wait for server to be started
    subject.inspect

    expect(Net::HTTP.get(URI("http://#{host}:#{port}"))).to eq body

    subject.terminate
  end
end