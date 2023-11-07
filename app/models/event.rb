class Event < ApplicationRecord
  has_many :attendances
  has_many :users, through: :attendances

  validates :start_date, presence: true
  #code pour indiquer pas de modif ou créa dans le passé
  validate :start_date_in_future

  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0, multiple_of: 5, message: "La durée doit être un nombre entier, multiple de 5 et supérieur à 0 min." }
  
  validates :title, presence: true, length: { in: 5..140, message: "Le titre doit comprendre entre 5 et 140 charactères." }
  
  validates :description, presence: true, length: { in: 20..1000, message: "La description doit comprendre entre 20 et 1 000 charactères." }
  
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 1000, message: "Le prix est compris entre 1 et 1 000 euros." }
  
  validates :location, presence: true
  
  private

  def start_date_in_future
    if start_date.present? && start_date < Date.today.to_s
      errors.add(:start_date, "La date ne peut pas être dans le passé")
    end
  end

end
