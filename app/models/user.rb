class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  enum gender: {male: 'male', female: 'female', other: 'other'}

  has_many :bookings
  has_many :events, through: :bookings


  def is_attending_event?(event_id)
    bookings.where(event_id: event_id).exists?
  end
end
