require 'spec_helper'

describe "Root path", :type => :feature do
  it "should return a valid response when visiting the root path" do
    get '/'
    last_response.should be_successful
  end

  it "should have an file chooser button" do
    visit '/'
    expect(page).to have_field('video', :type => 'file')
  end

  it "should have an upload button" do
    visit '/'
    expect(page).to have_css('input[type="submit"]')
  end

end
