class CreateColumns < ActiveRecord::Migration[5.0]
  def change
    create_table :columns do |t|
      t.string :name
      t.integer :max_slots

      t.timestamps
    end
  end
end
