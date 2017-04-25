# == Schema Information
#
# Table name: cards
#
#  id         :integer          not null, primary key
#  name       :string
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Card < ApplicationRecord
  validates_presence_of :name

  attr_accessor :list_id

end
