require 'rails_helper'

RSpec.describe MyEvent, type: :model do
  describe "#save" do
    before do
      @region = FactoryGirl.create(:region)
    end
    it "let venue can't be saved with duplicate of name" do
      region1 = Venue.new(name:'Chill Sky Bar', region: @region)

      expect(region1.valid?).to be_truthy
      expect(region1.save).to be true

      region2 = Venue.new(name:'Chill Sky Bar', region: @region)
      expect(region2.valid?).to be_falsey
    end
  end
end
