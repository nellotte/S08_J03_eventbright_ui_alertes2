class User < ApplicationRecord
  has_many :attendances
  has_many :events, through: :attendances

  has_many :created_events, class_name: 'Event', foreign_key: 'admin_id'
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
end
