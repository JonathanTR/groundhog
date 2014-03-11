require 'spec_helper'

feature "User clicks upload" do
  let(:video_path){'spec/resources/grasshopper_test.mp4'}
  let(:temp_video_path){"public/temp_video/grasshopper_test.mp4"}
  let(:temp_gif_path){"public/temp_gif/grasshopper_test.gif"}

  before :each do
    visit '/'
  end

  scenario "and attached a valid file" do
    page.attach_file('video', 'spec/resources/grasshopper_test.mp4')
    click_button("Make a gif!")
    expect(page.status_code).to be(200)
  end

  scenario "but did not attach a file", js: true do
    click_button("Make a gif!")
    expect(page).to have_content('Please choose a file to upload.')
  end

  scenario "but attached an invalid file type" do
    page.attach_file('video', 'spec/resources/invalid.txt')
    click_button("Make a gif!")
    expect(page.status_code).to be(406)
    expect(page).to have_content('Please upload a valid filetype.')
    expect(File.exist?('public/temp_video/invalid.txt')).to be_false
  end

  scenario "the file should be saved to a temp_video folder" do
    page.attach_file('video', 'spec/resources/grasshopper_test.mp4')
    click_button("Make a gif!")
    expect(File.exist?(temp_video_path)).to be_true
    File.delete(temp_video_path)
  end

  scenario "user should see a video preview page" do
    page.attach_file('video', 'spec/resources/grasshopper_test.mp4')
    click_button("Make a gif!")
    expect(page).to have_selector("video[src='temp_video/grasshopper_test.mp4']")
  end

    page.attach_file('video', 'spec/resources/grasshopper_test.mp4')
    click_button("Make a gif!")
    expect(File.exist?(temp_video_path)).to be_true
    File.delete(temp_gif_path)
  end

  scenario "the user should be redirected to a download page" do
    page.attach_file('video', 'spec/resources/grasshopper_test.mp4')
    click_button("Make a gif!")
    expect(page).to have_selector("img[src='temp_gif/grasshopper_test.gif']")
  end

  scenario "the user should be redirected to a download page" do
    page.attach_file('video', 'spec/resources/grasshopper_test.mp4')
    click_button("Make a gif!")
    expect(page).to have_selector("a[href='temp_gif/grasshopper_test.gif']")
  end

end