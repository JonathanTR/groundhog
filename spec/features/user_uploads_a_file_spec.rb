require 'spec_helper'

feature "User clicks upload" do
  
  scenario "and attaches a valid file" do
    visit '/'
    page.attach_file('video', 'spec/resources/grasshopper_test.mp4')
    click_button("Upload!")
    expect(page.status_code).to be(200)
  end

end