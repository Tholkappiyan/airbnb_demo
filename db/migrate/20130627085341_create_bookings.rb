class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer  :user_id
      t.integer  :property_id
      t.datetime :book_from
      t.datetime :book_till
      t.integer  :count

      t.timestamps
    end
  end
end
