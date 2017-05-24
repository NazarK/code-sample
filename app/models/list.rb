# == Schema Information
#
# Table name: lists
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class List < ApplicationRecord
  has_many :slots, dependent: :destroy
  has_many :cards, through: :slots

  validates_presence_of :name
  validates_uniqueness_of :name

  after_save do
    if self.position.blank?
      self.update_attributes position: self.id
    end
  end

end
