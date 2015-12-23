class CreateBookTickets < ActiveRecord::Migration
  def change
    create_table :book_tickets do |t|
      t.integer :quantity
      t.references :ticket_type, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
