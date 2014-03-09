require 'spec_helper'

feature "User clicks upload" do
  
  scenario "and attached a valid file" do
    visit '/'
    page.attach_file('video', 'spec/resources/grasshopper_test.mp4')
    click_button("Upload!")
    expect(page.status_code).to be(200)
  end

  scenario "but did not attach a file", js: true do
    visit '/'
    click_button("Upload!")
    expect(page).to have_content('Please choose a file to upload.')
  end

  scenario "but attached an invalid file type" do
    visit '/'
    page.attach_file('video', 'spec/resources/invalid.txt')
    click_button("Upload!")
    expect(page.status_code).to be(406)
    expect(page).to have_content('Please upload a valid filetype.')
  end

end