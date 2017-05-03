# == Schema Information
#
# Table name: slots
#
#  id           :integer          not null, primary key
#  list_id      :integer
#  card_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  card_type_id :integer
#

class Slot < ApplicationRecord
  belongs_to :list
  belongs_to :card, optional: true, dependent: :destroy
  validates_uniqueness_of :card_id, allow_nil: true
  belongs_to :card_type, optional: true


  validate do
    if self.card_type_id.present? && self.card.present? && self.card.card_type_id != self.card_type_id
      self.errors[:card_type] << "card type doesn't match slot type (#{self.card_type.name})"
    end
  end
end
