class Client < ApplicationRecord
  NAME_MAX_LENGTH = 100

  has_many :appointments

  validates :name, presence: true, length: { maximum: NAME_MAX_LENGTH }
  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
