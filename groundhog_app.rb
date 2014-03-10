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
    filename = params["video"][:filename]
    gif_start_point = params["start-time"].to_i
    gif_duration = params["end-time"].to_i - gif_start_point
    video_title = strip_filetype(filename)
    target_path = "public/temp_video/#{filename}"
    gif_path = "public/temp_gif/#{video_title}.gif"
    VideoConverter.copy_to_temp_video(target_path, file_source.path)
    VideoConverter.convert_to_gif(gif_path, target_path, gif_start_point, gif_duration)
    @gif_path = gif_path.gsub!("public/", "")
    @gif_title = "#{video_title}.gif"
    erb :download
  end
end

private

def strip_filetype(path)
  path.gsub(/\.[a-z\d]{3,4}$/, "")
end