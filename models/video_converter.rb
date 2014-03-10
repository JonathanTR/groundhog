require 'streamio-ffmpeg'

class VideoConverter

  def self.copy_to_temp_video(target_path, file_path)
    File.open(target_path, 'w'){|f| f.write File.read(file_path)}
  end

  def self.convert_to_gif(target_path, source_path)
    video = FFMPEG::Movie.new(source_path)
    video.transcode(target_path, "-ss 5 -t 3 -r 32")
  end
  
end