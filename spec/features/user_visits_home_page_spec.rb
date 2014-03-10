require 'spec_helper'

describe "Root path", :type => :feature do
  before :each do
    visit '/'
  end

  it "should return a valid response when visiting the root path" do
    get '/'
    last_response.should be_successful
  end

  it "should have a file uploader form" do
    expect(page).to have_css('form[method="post"]')
  end

  it "should have an file chooser button" do
    expect(page).to have_field('video', :type => 'file')
  end

  it "should have an upload button" do
    expect(page).to have_css('input[type="submit"]')
  end

  it "should have a field for a start point" do
    expect(page).to have_css('input[name="start-time"]')
  end

  it "should have a field for an end point" do
    expect(page).to have_css('input[name="end-time"]')
  end

end
