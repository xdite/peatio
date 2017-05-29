# == Schema Information
#
# Table name: authentications
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  token      :string(255)
#  secret     :string(255)
#  member_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  nickname   :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentication do
    provider "MyString"
    uid "MyString"
    token "MyString"
    secret "MyString"
    member_id 1
  end
end
