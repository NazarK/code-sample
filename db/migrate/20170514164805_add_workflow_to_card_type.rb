class AddWorkflowToCardType < ActiveRecord::Migration[5.0]
  def change
    add_reference :card_types, :workflow, foreign_key: true
  end
end
