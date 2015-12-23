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
      tickets[type.id] = ticket_quantity_type_book if ticket_quantity_type_book.to_i.between?(1,10)
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

    @book_tickets = []
    @total = 0

    tickets.each do |key, value|
      book_ticket = BookTicket.new
      book_ticket.event = @event
      book_ticket.ticket_type = TicketType.find(key)
      book_ticket.quantity = value
      book_ticket.user = current_user
      book_ticket.save

      @book_tickets << book_ticket
      
      ticket = TicketType.find(key)
      @total += ticket.price * value.to_i

      TicketType.update(key,:max_quantity =>  ticket.max_quantity - value.to_i)
    end

    puts tickets

    render "tickets/result"
    # redirect_to root_path
  end
end
