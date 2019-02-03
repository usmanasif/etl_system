class Appointment < ApplicationRecord
  belongs_to :client

  validates :begin_at, :end_at, presence: true
end
