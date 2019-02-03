class Company < ApplicationRecord
  NAME_MAX_LENGTH = 50

  validates :name, presence: true, length: { maximum: NAME_MAX_LENGTH }
end
