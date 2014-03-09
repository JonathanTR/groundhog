require 'spec_helper'

describe "VideoConverter" do
  let(:video_path){'spec/resources/grasshopper_test.mp4'}
  let(:video_name){'grasshopper_test.mp4'}
  let(:temp_input_path){"public/temp_input/#{video_name}"}

  it "should accept a video path" do
    expect(VideoConverter.convert_to_gif(video_path)).not_to raise_error
  end

  it "should copy the video file to the temp_input folder" do
    VideoConverter.copy_to_temp_input(temp_input_path, video_path)
    original = File.read(video_path)
    result = File.read(temp_input_path)
    expect(original).to eq(result)
    File.delete(temp_input_path)
  end
end