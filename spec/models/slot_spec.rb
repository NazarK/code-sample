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

require 'rails_helper'

RSpec.describe Slot, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
