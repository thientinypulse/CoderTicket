class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def book
    event_id = params[:event_id]
    @event = Event.find(event_id)

    ticket = {}

    out_of_quantity = []

    @event.ticket_types.each do |type|
      ticket_quantity_type_book = params['quantity_'+type.id.to_s]
      out_of_quantity << type.id if ticket_quantity_type_book.to_i > type.max_quantity
      puts ticket_quantity_type_book
      ticket[type.id] = ticket_quantity_type_book
    end

    if out_of_quantity.any?
      out_of_quantity.each do |type|
        flash[:error] ||= ''
        flash[:error] << "There is not enough ticket of #{TicketType.find(type).name} <br>"
      end

      render "tickets/new"
      return
    end

    puts ticket

    redirect_to root_path
  end
end
