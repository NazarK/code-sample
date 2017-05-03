# == Schema Information
#
# Table name: card_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :card_type do
    name "MyString"
  end
end
