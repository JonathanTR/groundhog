class VideoConverter

  def self.copy_to_temp_input(target_path, file_path)
    File.open(target_path, 'w'){|f| f.write File.read(file_path)}
  end

  def self.convert_to_gif(source_path)
  end
  
end