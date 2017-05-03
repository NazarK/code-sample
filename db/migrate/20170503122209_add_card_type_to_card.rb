class AddCardTypeToCard < ActiveRecord::Migration[5.0]
  def change
    add_reference :cards, :card_type, foreign_key: true
  end
end
