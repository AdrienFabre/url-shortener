require 'sinatra/base'

class UrlShortener < Sinatra::Base
  enable :sessions

  get '/' do
    erb :index
  end

  post '/' do
    session[:url] = params[:name]
    @url = session[:url]
    erb :index
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end