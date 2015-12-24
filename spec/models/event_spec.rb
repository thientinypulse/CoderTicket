require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "#save" do
    before do
      @region = FactoryGirl.create(:region)
      @venue = FactoryGirl.create(:venue, region: @region)
      @category = FactoryGirl.create(:category)
    end
    it "let event can't be saved by validation of venue" do
      event = Event.new
      expect(event.valid?).to be_falsey
      expect(event.errors[:venue].size).to eq(1)
    end

    it "let event can't be saved by validation of description" do
      event = Event.new(venue: @venue)

      expect(event.valid?).to be_falsey
      expect(event.errors[:venue].size).to eq(0)
      expect(event.errors[:extended_html_description].size).to eq(1)
    end

    it "let event can't be saved by validation of category" do
      event = Event.new(venue: @venue, extended_html_description: 'extended_html_description')

      expect(event.valid?).to be_falsey
      expect(event.errors[:venue].size).to eq(0)
      expect(event.errors[:extended_html_description].size).to eq(0)
      expect(event.errors[:category].size).to eq(1)
    end

    it "let event can't be saved by validation of starts_at" do
      event = Event.new(venue: @venue, extended_html_description: 'extended_html_description', category: @category)

      expect(event.valid?).to be_falsey
      expect(event.errors[:venue].size).to eq(0)
      expect(event.errors[:extended_html_description].size).to eq(0)
      expect(event.errors[:category].size).to eq(0)
      expect(event.errors[:starts_at].size).to eq(1)
    end

    it "let event can be saved" do
      event = Event.new(venue: @venue, extended_html_description: 'extended_html_description', category: @category, starts_at: Time.now)

      expect(event.valid?).to be_truthy
      expect(event.save).to be true
    end

    it "let event can't be saved with duplicate of name" do
      event1 = Event.new(name: 'Chrismas',venue: @venue, extended_html_description: 'extended_html_description', category: @category, starts_at: Time.now)

      expect(event1.valid?).to be_truthy
      expect(event1.save).to be true

      event2 = Event.new(name: 'Chrismas',venue: @venue, extended_html_description: 'extended_html_description', category: @category, starts_at: Time.now)
      expect(event2.valid?).to be_falsey
    end
  end
end
