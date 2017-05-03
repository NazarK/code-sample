class AddCardTypeToSlot < ActiveRecord::Migration[5.0]
  def change
    add_reference :slots, :card_type, foreign_key: true
  end
end
