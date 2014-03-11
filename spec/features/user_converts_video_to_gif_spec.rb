require 'spec_helper'

feature "User creates a gif" do
  let(:temp_video_path){"public/temp_video/grasshopper_test.mp4"}
  let(:temp_gif_path){"public/temp_gif/grasshopper_test.gif"}

  before :each do
    visit '/'
    page.attach_file('video', 'spec/resources/grasshopper_test.mp4')
    click_button("Upload!")
  end

  xscenario "the file should be converted to a gif" do
    expect(File.exist?(temp_video_path)).to be_true
    File.delete(temp_gif_path)
  end

  xscenario "the user should be redirected to a download page" do
    click_button("Make a gif!")
    expect(page).to have_selector("img[src='temp_gif/grasshopper_test.gif']")
  end

  xscenario "the user should be redirected to a download page" do
    click_button("Make a gif!")
    expect(page).to have_selector("a[href='temp_gif/grasshopper_test.gif']")
  end

end
