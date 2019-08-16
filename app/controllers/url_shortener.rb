require 'sinatra/base'
require './app/models/shortener'

class UrlShortener < Sinatra::Base
  set :views, File.expand_path('app/views')

  get '/' do
    erb :index
  end

  post '/' do
    url = params[:url] ? params : JSON.parse(params.keys[0])
    @url_pair = Shortener.process_url(url)
    erb :index
  end

  get '/:short_url' do
    url_pair = Shortener.retrieve_pair_by_short_url(params[:short_url])
    redirect to(url_pair['url'].to_s), 301, url_pair.to_s
  end

  run! if app_file == $0
end
