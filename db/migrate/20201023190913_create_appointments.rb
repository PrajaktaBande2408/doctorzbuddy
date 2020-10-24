class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.references :patient, foreign_key: true
      t.references :slot, foreign_key: true
      t.integer    :status
      t.timestamps
    end
  end
end