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
    @filename = params["video"][:filename]
    video_storage_path = "public/temp_video/#{@filename}"
    VideoConverter.copy_to_temp_video(video_storage_path, file_source.path)
    @video_storage_link = strip_public_folder(video_storage_path)
    erb :preview
  end
end

    gif_storage_path = "public/temp_gif/#{strip_filetype(filename)}.gif"
    gif_start_point = params["start-time"].to_i
    gif_duration = params["end-time"].to_i - gif_start_point
    VideoConverter.convert_to_gif(gif_storage_path, video_storage_path, gif_start_point, gif_duration)

    @gif_path = gif_storage_path.gsub!("public/", "")
    @gif_title = "#{strip_filetype(filename)}.gif"
    erb :download
  end
end

private

def strip_filetype(path)
  path.gsub(/\.[a-z\d]{3,4}$/, "")
end

def strip_public_folder(path)
  path.gsub("public/", "")
end