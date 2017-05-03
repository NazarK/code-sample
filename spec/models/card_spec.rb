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

require 'rails_helper'

RSpec.describe Card, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
