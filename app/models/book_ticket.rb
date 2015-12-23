class BookTicket < ActiveRecord::Base
  belongs_to :ticket_type
  belongs_to :user
  belongs_to :event
end
