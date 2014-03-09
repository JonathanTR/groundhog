require 'sinatra'
require_relative 'models/init'

get '/' do
  erb :index
end

post '/upload' do
  filetype = params["video"][:type]
  if filetype != "application/mp4"
    status 406
    erb :error_406
  else
    video_file = params["video"][:tempfile]
    video_name = params["video"][:filename]
    target_path = "public/temp_input/#{video_name}"
    VideoConverter.copy_to_temp_input(target_path, video_file.path)
    redirect '/'
  end
end
