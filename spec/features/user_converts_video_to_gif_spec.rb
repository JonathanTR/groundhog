require 'spec_helper'

feature "User creates a gif" do
  let(:temp_video_path){"public/temp_video/grasshopper_test.mp4"}
  let(:temp_gif_path){"public/temp_gif/grasshopper_test.gif"}

  before :each do
    visit '/'
    page.attach_file('video', 'spec/resources/grasshopper_test.mp4')
    click_button("Upload!")
  end

  after :each do
    File.delete(temp_video_path) if File.exist?(temp_video_path)
    File.delete(temp_gif_path) if File.exist?(temp_gif_path)
  end

  scenario "form on display page should access '/convert' route" do
    expect(page).to have_selector("form[action='/convert']")
  end

  scenario "the file should be converted to a gif" do
    fill_in("start-time", :with => 5)
    fill_in("end-time", :with => 8)
    click_button("Make a gif!")
    expect(File.exist?(temp_gif_path)).to be_true
  end

  scenario "the user should be redirected to a download page" do
    fill_in("start-time", :with => 5)
    fill_in("end-time", :with => 8)
    click_button("Make a gif!")
    expect(page).to have_selector("img[src='temp_gif/grasshopper_test.gif']")
  end

  scenario "the user should be redirected to a download page" do
    click_button("Make a gif!")
    expect(page).to have_selector("a[href='temp_gif/grasshopper_test.gif']")
  end

end
