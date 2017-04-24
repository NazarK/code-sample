class CreateSlots < ActiveRecord::Migration[5.0]
  def change
    create_table :slots do |t|
      t.references :column, foreign_key: true
      t.references :card, foreign_key: true

      t.timestamps
    end
  end
end
