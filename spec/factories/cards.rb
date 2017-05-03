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

FactoryGirl.define do
  factory :card do
    name "MyString"
    text "MyText"
  end
end
