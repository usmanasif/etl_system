class Service < ApplicationRecord
  NAME_MAX_LENGTH = 100

  has_many :appointment_services
  has_many :appointments, through: :appointment_services

  validates :name, presence: true, length: { maximum: NAME_MAX_LENGTH }
end
