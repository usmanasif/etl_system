class Appointment < ApplicationRecord
  belongs_to :company
  belongs_to :client

  has_many :appointment_services
  has_many :services, through: :appointment_services

  validates :begin_at, :end_at, presence: true
  validates :reference_id, uniqueness: { scope: :company }
end
