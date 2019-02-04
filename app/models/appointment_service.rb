class AppointmentService < ApplicationRecord
  belongs_to :appointment
  belongs_to :service

  validates :reference_id, uniqueness: { message: 'Already Loaded' }
end
