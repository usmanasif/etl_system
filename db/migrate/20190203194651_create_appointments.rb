class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.datetime :begin_at, null: false
      t.datetime :end_at, null: false
      t.references :client

      t.timestamps
    end
  end
end
