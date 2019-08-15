require 'spec_helper'
require 'rack/test'

describe 'Controller: UrlShortener' do
  include Rack::Test::Methods

  def app
    UrlShortener.new
  end

  it 'displays home page' do
    get '/'
    expect(last_response.status).to eq(200)
  end

  it 'redirects to saved url' do
    stub_const('Shortener::FILE', 'url_pairs_test.json')
    allow(Shortener).to receive(:rand).and_return(1)
    get '/'
    expect(last_response.status).to eq(200)
    post '/', 'url' => 'http://adrienfabre.dev'
    get '/bbbbbb'
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_request.url).to eq('http://adrienfabre.dev/')
  end
end
