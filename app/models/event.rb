class Event < ApplicationRecord
  
  has_many :bookings
  has_many :users, through: :bookings


  def is_future_event?
    start_time > Time.now
  end

end