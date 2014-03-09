require 'spec_helper'

feature "User clicks upload" do
  let(:video_path){'spec/resources/grasshopper_test.mp4'}
  let(:video_name){'grasshopper_test.mp4'}
  let(:temp_input_path){"public/temp_input/#{video_name}"}

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
  end

  scenario "the file should be saved to a temp_input folder" do
    page.attach_file('video', 'spec/resources/grasshopper_test.mp4')
    click_button("Upload!")
    expect(File.exist?(temp_input_path)).to be_true
    File.delete(temp_input_path)
  end

end