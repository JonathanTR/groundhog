require 'spec_helper'

describe "VideoConverter" do
  let(:video_path){'spec/resources/grasshopper_test.mp4'}

  it "should accept a video path" do
    expect(VideoConverter.makeGif(video_path)).not_to raise_error
  end
end