require 'rails_helper'

RSpec.describe "events/new", :type => :view do
  before do
    @region = FactoryGirl.create(:region)
    @venue = FactoryGirl.create(:venue, region: @region)
    @category = FactoryGirl.create(:category)
  end
  it "renders events/new template" do
    assign(:event, Event.new)

    render
    expect(rendered).to include("Create new event")
  end
end

RSpec.describe "events/index", :type => :view do
  before do
    @region = FactoryGirl.create(:region)
    @venue = FactoryGirl.create(:venue, region: @region)
    @category = FactoryGirl.create(:category)
  end
  it "renders events/new template" do

    event = Event.create(venue: @venue, extended_html_description: 'extended_html_description', category: @category, starts_at: Time.now)
    assign(:events, [event])
    render
    expect(rendered).to include("Discover upcoming events")
  end
end