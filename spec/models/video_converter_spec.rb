require 'spec_helper'

describe "VideoConverter" do
  let(:video_path){'spec/resources/grasshopper_test.mp4'}
  let(:video_name){'grasshopper_test'}
  let(:temp_input_path){"public/temp_input/#{video_name}.mp4"}
  let(:temp_output_path){"public/temp_output/#{video_name}.gif"}

  after :each do
    File.delete(temp_input_path) if File.exist?(temp_input_path)
    File.delete(temp_output_path) if File.exist?(temp_output_path)
  end

  it "should accept a video path" do
    expect(VideoConverter.convert_to_gif(temp_output_path, video_path)).not_to raise_error
  end

  it "should copy the video file to the temp_input folder" do
    VideoConverter.copy_to_temp_input(temp_input_path, video_path)
    original = File.read(video_path)
    result = File.read(temp_input_path)
    expect(original).to eq(result)
  end

  it "should output a gif file to the temp_output folder" do
    VideoConverter.copy_to_temp_input(temp_input_path, video_path)
    VideoConverter.convert_to_gif(temp_output_path, temp_input_path)
    expect(File.exist?(temp_output_path)).to be_true
  end
end