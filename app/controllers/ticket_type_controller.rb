class TicketTypeController < ApplicationController
  def create
    TicketType.create(ticket_type_param)
    redirect_to myevent_detail_path(params[:ticket_type][:event_id])

  end
  
  private
  def ticket_type_param
    params.require(:ticket_type).permit(:event_id, :name, :price, :max_quantity)
  end
end
