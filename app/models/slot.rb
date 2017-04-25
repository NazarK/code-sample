# == Schema Information
#
# Table name: slots
#
#  id         :integer          not null, primary key
#  list_id    :integer
#  card_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Slot < ApplicationRecord
  belongs_to :list
  belongs_to :card, optional: true, dependent: :destroy
end
