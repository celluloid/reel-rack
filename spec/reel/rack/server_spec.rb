require 'spec_helper'
require 'net/http'
require 'rack/lint'
require 'rack/head'

describe Reel::Rack::Server do
  let(:host) { "127.0.0.1" }
  let(:port) { 30000 }
  let(:body) { "hello world" }

  subject do
    app = proc { [200, {"Content-Type" => "text/plain"}, [body]] }
    described_class.new(Rack::Lint.new(Rack::Head.new(app)), :Host => host, :Port => port)
  end

  it "runs a basic Hello World app" do
    # Hax to wait for server to be started
    subject.inspect

    expect(Net::HTTP.get(URI("http://#{host}:#{port}"))).to eq body

    subject.terminate
  end

  it "success with basic HTTP methods" do
    # Hax to wait for server to be started
    subject.inspect

    uri = URI("http://#{host}:#{port}/")
    http = Net::HTTP.new(uri.host, uri.port)
    http.set_debug_output($stderr)

    expect(http.request_get(uri.path).body).to eq body
    expect(http.request_head(uri.path).body).to eq nil

    expect(http.send_request('POST', uri.path, "test").body).to eq body
    expect(http.send_request('PUT', uri.path, "test").body).to eq body
    expect(http.send_request('PATCH', uri.path, "test").body).to eq body
    expect(http.send_request('DELETE', uri.path).body).to eq body

    subject.terminate
  end
end
