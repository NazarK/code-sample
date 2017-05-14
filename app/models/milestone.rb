class Milestone < ApplicationRecord
  belongs_to :workflow
  validates_presence_of :workflow
end
