class User < ApplicationRecord
  after_create :welcome_send
  has_many :attendances
  has_many :events, through: :attendances

  has_many :created_events, class_name: 'Event', foreign_key: 'admin_id'
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def welcome_send
  UserMailer.welcome_email(self).deliver_now
  end
    
  def participating?(event)
    events.include?(event)
  end
  
end
