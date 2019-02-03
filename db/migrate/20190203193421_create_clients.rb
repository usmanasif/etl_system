class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name, null: false, limit: 100
      t.string :email, null: false

      t.timestamps
    end

    add_index :clients, :email
  end
end
