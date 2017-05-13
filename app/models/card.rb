# == Schema Information
#
# Table name: cards
#
#  id           :integer          not null, primary key
#  name         :string
#  text         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  card_type_id :integer
#

class Card < ApplicationRecord
  validates_presence_of :name
  belongs_to :card_type, optional: true

  attr_accessor :list_id


  def color
    "#ff0000"
  end
end
