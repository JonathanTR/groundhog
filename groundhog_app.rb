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
  filename = params["filename"]
  video_storage_path = "public/temp_video/#{filename}"
  gif_storage_path = "public/temp_gif/#{strip_filetype(filename)}.gif"
  gif_start_point = params["start-time"].to_i
  gif_duration = params["end-time"].to_i - gif_start_point
  VideoConverter.convert_to_gif(gif_storage_path, video_storage_path, gif_start_point, gif_duration)

  @gif_path = gif_storage_path.gsub!("public/", "")
  @gif_title = "#{strip_filetype(filename)}.gif"
  erb :download
end

delete '/destroy/:filename' do
  filename = params[:filename]
  File.delete("public/temp_video/#{strip_filetype(filename)}.mp4")
  File.delete("public/temp_gif/#{filename}")
  "complete"
end

private

def strip_filetype(path)
  path.gsub(/\.[a-z\d]{3,4}$/, "")
end

def return_filetype(path)
  path[/(?<=\/)[a-z\d]{3,4}$/]
end

def strip_public_folder(path)
  path.gsub("public/", "")
end
