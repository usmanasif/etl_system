class AppointmentService < ApplicationRecord
  belongs_to :company
  belongs_to :appointment
  belongs_to :service

  validates :reference_id, uniqueness: { scope: :company }
end
