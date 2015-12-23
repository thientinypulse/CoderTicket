class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def book
    event_id = params[:event_id]
    @event = Event.find(event_id)

    tickets = {}

    out_of_quantity = []

    @event.ticket_types.each do |type|
      ticket_quantity_type_book = params['quantity_'+type.id.to_s]
      out_of_quantity << type.id if ticket_quantity_type_book.to_i > type.max_quantity
      puts ticket_quantity_type_book
      tickets[type.id] = ticket_quantity_type_book
    end

    if out_of_quantity.any?
      errors = ''
      out_of_quantity.each do |type|
        errors << TicketType.find(type).name + ' '
      end
      flash[:error] = "There is not enough ticket of #{errors}"
      render "tickets/new"
      return
    end

    tickets.each do |key, value|
      book_ticket = BookTicket.new
      book_ticket.event = @event
      book_ticket.ticket_type = TicketType.find(key)
      book_ticket.quantity = value
      book_ticket.user = current_user
      book_ticket.save
    end

    puts tickets

    redirect_to root_path
  end
end
