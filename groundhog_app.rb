require 'sinatra'

get '/' do
  erb :index
end

post '/upload' do
  filetype = params["video"][:type]
  if filetype != "application/mp4"
    status 406
    erb :error_406
  end
end