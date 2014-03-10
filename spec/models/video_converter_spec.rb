require 'spec_helper'

describe "VideoConverter" do
  let(:video_path){'spec/resources/grasshopper_test.mp4'}
  let(:video_name){'grasshopper_test'}
  let(:temp_video_path){"public/temp_video/#{video_name}.mp4"}
  let(:temp_gif_path){"public/temp_gif/#{video_name}.gif"}

  after :each do
    File.delete(temp_video_path) if File.exist?(temp_video_path)
    File.delete(temp_gif_path) if File.exist?(temp_gif_path)
  end

  it "should accept a video path" do
    expect(VideoConverter.convert_to_gif(temp_gif_path, video_path)).not_to raise_error
  end

  it "should copy the video file to the temp_video folder" do
    VideoConverter.copy_to_temp_video(temp_video_path, video_path)
    original = File.read(video_path)
    result = File.read(temp_video_path)
    expect(original).to eq(result)
  end

  it "should output a gif file to the temp_gif folder" do
    VideoConverter.copy_to_temp_video(temp_video_path, video_path)
    VideoConverter.convert_to_gif(temp_gif_path, temp_video_path)
    expect(File.exist?(temp_gif_path)).to be_true
  end

  it "should produce a gif with the same resolution by default" do
    VideoConverter.copy_to_temp_video(temp_video_path, video_path)
    VideoConverter.convert_to_gif(temp_gif_path, temp_video_path)
    video = FFMPEG::Movie.new(temp_video_path)
    gif = FFMPEG::Movie.new(temp_gif_path)
    expect(video.resolution).to eq(gif.resolution)
  end

  it "should produce a valid gif file" do
    VideoConverter.copy_to_temp_video(temp_video_path, video_path)
    VideoConverter.convert_to_gif(temp_gif_path, temp_video_path)
    gif = FFMPEG::Movie.new(temp_gif_path)
    expect(gif.valid?).to be_true
  end
end