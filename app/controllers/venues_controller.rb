class VenuesController < ApplicationController
  def new
  	@venue = Venue.new
  end

  def create
  	@venue = Venue.create(venue_params)

  end

private
  def venue_params
    params.require(:venue).permit(:name, :full_address, :venue_id)
  end
end
