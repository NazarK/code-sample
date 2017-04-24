class Slot < ApplicationRecord
  belongs_to :column
  belongs_to :card
end
