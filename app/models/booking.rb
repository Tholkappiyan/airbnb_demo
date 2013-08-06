class Booking < ActiveRecord::Base
  attr_accessible :book_from, :book_till, :count, :user_id, :property_id, :id
  belongs_to :user
  belongs_to :property

  default_scope order: 'bookings.book_from DESC'

  validate :check_availabilty

  def check_availabilty
  	avail = property.isAvail?(id, book_from.to_i, book_till.to_i)

  	if(avail==false)
  		errors.add(:base, "The property is booked in the requested date")
  	end
  end

end