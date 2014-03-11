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
    click_button("Upload!")
    expect(page.status_code).to be(200)
  end

  scenario "but did not attach a file", js: true do
    click_button("Upload!")
    expect(page).to have_content('Please choose a file to upload.')
  end

  scenario "but attached an invalid file type" do
    page.attach_file('video', 'spec/resources/invalid.txt')
    click_button("Upload!")
    expect(page.status_code).to be(406)
    expect(page).to have_content('Please upload a valid filetype.')
    expect(File.exist?('public/temp_video/invalid.txt')).to be_false
  end

  scenario "the file should be saved to a temp_video folder" do
    page.attach_file('video', 'spec/resources/grasshopper_test.mp4')
    click_button("Upload!")
    expect(File.exist?(temp_video_path)).to be_true
    File.delete(temp_video_path)
  end

  scenario "user should see a video preview page" do
    page.attach_file('video', 'spec/resources/grasshopper_test.mp4')
    click_button("Upload!")
    expect(page).to have_selector("video[src='temp_video/grasshopper_test.mp4']")
  end

  scenario "preview page should have an input for gif start" do
    page.attach_file('video', 'spec/resources/grasshopper_test.mp4')
    click_button("Upload!")
    expect(page).to have_selector("input[name='start-time']")
  end

  scenario "preview page should have an input for gif end" do
    page.attach_file('video', 'spec/resources/grasshopper_test.mp4')
    click_button("Upload!")
    expect(page).to have_selector("input[name='end-time']")
  end

  scenario "preview page should have a 'Make a gif!' button" do
    page.attach_file('video', 'spec/resources/grasshopper_test.mp4')
    click_button("Upload!")
    expect(page).to have_selector("input[value='Make a gif!']")
  end

end