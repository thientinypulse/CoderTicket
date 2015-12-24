class VenuesController < ApplicationController
  def new
  	@venue = Venue.new
  end

  def create
  	@venue = Venue.new(venue_params)

    unless @venue.valid?
      render 'new'
      return
    end

    @venue.save

  end

private
  def venue_params
    params.require(:venue).permit(:name, :full_address, :venue_id)
  end
end
