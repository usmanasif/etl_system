class AddReferenceIds < ActiveRecord::Migration[5.2]
  def change
    add_column :services, :reference_id, :integer
    add_column :clients, :reference_id, :integer
    add_column :appointments, :reference_id, :integer
    add_column :appointment_services, :reference_id, :integer

    add_index :services, :reference_id
    add_index :clients, :reference_id
    add_index :appointments, :reference_id
    add_index :appointment_services, :reference_id
  end
end
