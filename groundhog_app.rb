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
    file_source = params["video"][:tempfile]
    video_name = params["video"][:filename]
    start = params["start-time"].to_i
    duration = params["end-time"].to_i - start
    video_title = strip_filetype(video_name)
    target_path = "public/temp_video/#{video_name}"
    gif_path = "public/temp_gif/#{video_title}.gif"
    VideoConverter.copy_to_temp_video(target_path, file_source.path)
    VideoConverter.convert_to_gif(gif_path, target_path, start, duration)
    @gif_path = gif_path.gsub!("public/", "")
    @gif_title = "#{video_title}.gif"
    erb :download
  end
end

private

def strip_filetype(path)
  path.gsub(/\.[a-z\d]{3,4}$/, "")
end