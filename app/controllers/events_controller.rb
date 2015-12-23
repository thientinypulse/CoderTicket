class EventsController < ApplicationController
  def index

    search = params[:search]
    if search
      @events = Event.where("starts_at > '#{Time.now}' AND LOWER(name) like '%#{search.downcase}%'")
    else
      @events = Event.where("starts_at > '#{Time.now}'")
    end

  end

  def show
    @event = Event.find(params[:id])
  end
end
