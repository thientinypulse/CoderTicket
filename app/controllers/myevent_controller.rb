class MyeventController < ApplicationController
  def index
    @myevents = MyEvent.where(user_id: current_user.id)
  end

  def edit
    event_info
  end
  
  def detail
    event_info

  end

  def renovate
    Event.update(params[:event][:event_id], event_params)
    redirect_to myevent_detail_path(params[:event][:event_id])
  end

  private
  def event_info
    event_id = params[:id]
    myevent = MyEvent.find_by(user_id:current_user.id, event_id: event_id)

    if myevent.nil?
      flash[:error] = "The event that you want to edit is not valid"
      redirect_to myevent_index_path
      return
    else
      @event = myevent.event
    end
  end

  def event_params
    params.require(:event).permit(:starts_at, :ends_at, :venue_id, :category_id, :name, :hero_image_url, :extended_html_description)
  end
end
