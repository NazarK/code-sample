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
  belongs_to :card_type, optional: true
end
