class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.default_scope
    where(company: Current.company) if belongs_to_company?
  end

  def self.belongs_to_company?
    Current.company && self.column_names.include?('company_id')
  end
end
