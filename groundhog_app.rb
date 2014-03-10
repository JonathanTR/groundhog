require 'sinatra'
require_relative 'models/init'

get '/' do
  erb :index
end

post '/upload' do
  filetype = params["video"][:type]
  unless filetype.include?("/mp4")
    status 406
    erb :error_406
  else
    video_file = params["video"][:tempfile]
    video_name = params["video"][:filename]
    video_title = strip_filetype(video_name)
    target_path = "public/temp_input/#{video_name}"
    gif_path = "public/temp_output/#{video_title}.gif"
    VideoConverter.copy_to_temp_input(target_path, video_file.path)
    VideoConverter.convert_to_gif(gif_path, target_path)
    redirect '/'
  end
end

private

def strip_filetype(path)
  path.gsub(/\.[a-z\d]{3,4}$/, "")
end