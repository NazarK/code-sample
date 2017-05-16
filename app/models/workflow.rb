class Workflow < ApplicationRecord
  has_many :milestones, dependent: :destroy
end