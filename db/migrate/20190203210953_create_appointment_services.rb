class CreateAppointmentServices < ActiveRecord::Migration[5.2]
  def change
    create_table :appointment_services do |t|
      t.references :appointment
      t.references :service

      t.timestamps
    end
  end
end
