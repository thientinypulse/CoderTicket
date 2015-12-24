require 'rails_helper'

RSpec.describe "routing to profiles", :type => :routing do
  it "routes /events" do
    expect(:get => "/events").to route_to(
                                              :controller => "events",
                                              :action => "index"
                                          )
  end

  it "routes /myevent/index" do
    expect(:get => "/myevent/index").to route_to(
                                     :controller => "myevent",
                                     :action => "index"
                                 )
  end
end