require 'sinatra'
require_relative 'models/init'

enable :sessions

get '/' do
  erb :index
end

post '/upload' do
  file_source = params["video"][:tempfile].path
  filetype = return_filetype(params["video"][:type])
  filename = strip_filetype(params["video"][:filename])
  session[:filename] = filename
  session[:type] = filetype
  unless ["mp4"].include?(filetype)
    status 406
    erb :error_406
  else
    video_storage_path = "public/temp_video/#{filename}.#{filetype}"
    VideoConverter.copy_to_temp_video(video_storage_path, file_source)
    @video_storage_link = "temp_video/#{filename}.#{filetype}"
    erb :preview
  end
end

post '/convert' do
  filename = session[:filename]
  filetype = session[:type]

  video_storage_path = "public/temp_video/#{filename}.#{filetype}"
  gif_storage_path = "public/temp_gif/#{filename}.gif"
  gif_start_point = params["start-time"].to_i
  gif_duration = params["end-time"].to_i - gif_start_point
  VideoConverter.convert_to_gif(gif_storage_path, video_storage_path, gif_start_point, gif_duration)

  @gif_path = "temp_gif/#{filename}.gif"
  @gif_title = "#{filename}.gif"
  erb :download
end

delete '/destroy' do
  filename = session[:filename]
  filetype = session[:type]
  File.delete("public/temp_video/#{filename}.#{filetype}")
  File.delete("public/temp_gif/#{filename}.gif")
  session.clear
  "complete"
end

private

def strip_filetype(path)
  path.gsub(/\.[a-z\d]{3,4}$/, "")
end

def return_filetype(path)
  path[/(?<=\/)[a-z\d]{3,4}$/]
end
