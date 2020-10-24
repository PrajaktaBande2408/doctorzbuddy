class CreateSlots < ActiveRecord::Migration[6.0]
  def change
    create_table :slots do |t|
      t.references :doctor, foreign_key: true
      t.datetime   :date
      t.float      :from_time
      t.float      :to_time
      t.boolean    :booked, default: false
      t.timestamps
    end
  end
end