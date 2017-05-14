# == Schema Information
#
# Table name: card_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CardType < ApplicationRecord
  strip_attributes
  belongs_to :workflow
  validates_uniqueness_of :name, case_sensitive: false
  validates_presence_of :name
end
