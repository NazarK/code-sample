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

FactoryGirl.define do
  factory :slot do
    list nil
    card nil
  end
end
