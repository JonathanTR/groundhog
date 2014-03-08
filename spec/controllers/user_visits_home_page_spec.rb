require 'spec_helper'

describe "Root path" do
  it "should return a valid response when visiting the root path" do
    get '/'
    last_response.should be_successful
  end
end
