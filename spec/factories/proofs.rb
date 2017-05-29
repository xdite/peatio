# == Schema Information
#
# Table name: proofs
#
#  id         :integer          not null, primary key
#  root       :string(255)
#  currency   :integer
#  ready      :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#  sum        :string(255)
#  addresses  :text
#  balance    :string(30)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :proof do
    root "MyString"
    state "MyString"
  end
end
