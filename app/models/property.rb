class Property < ActiveRecord::Base
  attr_accessible :prop_type, :rate, :avail_start, :avail_end, :addr1, :addr2, :city, :state, :title, :description, :image
  belongs_to :user
  has_many   :bookings, dependent: :destroy 

  has_attached_file :image, :styles => { :medium => "300x300>" },
                    :url => "/assets/properties/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/properties/:id/:style/:basename.:extension"

  validates_attachment_content_type :image, :content_type => ['image/jpeg' , 'image/png']

  scope :with_city, lambda {|city| (city!="") ? {:conditions => {:city => city}} : {} }
  scope :with_start, lambda {|start| (start!="") ? {:conditions => ['avail_start <= ?',start << " 00:00:00 UTC"] } 
                                                 : {:conditions => ["avail_start <= '31-12-9999 00:00:00 UTC'" ] } }
  scope :with_end, lambda {|till| (till!="") ? {:conditions => ['avail_end >= ?',till << " 00:00:00 UTC"] }
                                             : {:conditions => ["avail_end >= '01-01-0001 00:00:00 UTC'" ] } }
  
  default_scope order: 'properties.created_at DESC'

  def isAvail?(book_id, new_from, new_to)
    @blocked = bookings.select { |b| ( (b.id != book_id) && 
                                  ( ((b.book_from.to_i..b.book_till.to_i).include?(new_from)) || 
                                    ((b.book_from.to_i..b.book_till.to_i).include?(new_to)) ) )  
                                }
    return false if(@blocked.count != 0)
    return true
  end
end