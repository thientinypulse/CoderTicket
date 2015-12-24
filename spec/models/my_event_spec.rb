require 'rails_helper'

RSpec.describe MyEvent, type: :model do
  describe "#save" do
    before do
      @user = FactoryGirl.create(:user)

    end
    it "let myevent can't be saved by validation of user" do
      myevent = MyEvent.new
      expect(myevent.valid?).to be_falsey
      expect(myevent.errors[:user].size).to eq(1)
    end

    it "let myevent can't be saved by validation of event" do
      myevent = MyEvent.new(user: @user)
      expect(myevent.valid?).to be_falsey
      expect(myevent.errors[:user].size).to eq(0)
      expect(myevent.errors[:event].size).to eq(1)
    end

    it "let myevent can be saved" do
      @region = FactoryGirl.create(:region)
      @venue = FactoryGirl.create(:venue, region: @region)
      @category = FactoryGirl.create(:category)
      @event = FactoryGirl.create(:event, venue: @venue, extended_html_description: 'extended_html_description', category: @category, starts_at: Time.now)

      myevent = MyEvent.new(user: @user, event: @event)
      expect(myevent.valid?).to be true
      expect(myevent.save).to be true
    end
  end
end
