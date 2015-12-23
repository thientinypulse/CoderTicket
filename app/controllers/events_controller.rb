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

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    myeven = MyEvent.new
    myeven.event = @event
    myeven.user = current_user
    myeven.save

    redirect_to root_path
  end
private
  def event_params
    params.require(:event).permit(:starts_at, :ends_at, :venue_id, :category_id, :name, :hero_image_url, :extended_html_description)
  end
end
