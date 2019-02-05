class Client < ApplicationRecord
  NAME_MAX_LENGTH = 100

  belongs_to :company

  has_many :appointments

  validates :name, presence: true, length: { maximum: NAME_MAX_LENGTH }
  validates :email, uniqueness: { scope: :company }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :reference_id, uniqueness: { scope: :company }
end
