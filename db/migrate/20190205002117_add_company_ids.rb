class AddCompanyIds < ActiveRecord::Migration[5.2]
  def change
    add_reference :services, :company
    add_reference :clients, :company
    add_reference :appointments, :company
    add_reference :appointment_services, :company
  end
end
