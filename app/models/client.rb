class Client < ApplicationRecord
  NAME_MAX_LENGTH = 100

  validates :name, presence: true, length: { maximum: NAME_MAX_LENGTH }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
