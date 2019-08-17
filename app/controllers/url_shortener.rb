require 'sinatra/base'
require './app/models/shortener'

class UrlShortener < Sinatra::Base
  set :views, File.expand_path('app/views')

  get '/' do
    erb :index
  end

  post '/' do
    url = params[:url] ? params : JSON.parse(params.keys[0])
    url['url'] = format_url(url['url'])
    @url_pair = valid_url?(url['url']) ? Shortener.process_url(url) : nil
    erb :index
  end

  get '/:short_url' do
    url_pair = Shortener.retrieve_pair_by_short_url(params[:short_url])
    redirect to(url_pair['url'].to_s), 301, url_pair.to_s
  end

  private

  HTTP_REGEX = %r{https?:\/\/[\S]+}.freeze

  def format_url(url)
    !(url =~ HTTP_REGEX).nil? ? url : "http://#{url}"
  end

  URL_REGEX = %r{^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$}ix
    .freeze

  def valid_url?(url)
    url.match? URL_REGEX
  end

  run! if app_file == $0
end
