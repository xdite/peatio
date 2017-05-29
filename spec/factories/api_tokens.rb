# == Schema Information
#
# Table name: api_tokens
#
#  id                    :integer          not null, primary key
#  member_id             :integer          not null
#  access_key            :string(50)       not null
#  secret_key            :string(50)       not null
#  created_at            :datetime
#  updated_at            :datetime
#  trusted_ip_list       :string(255)
#  label                 :string(255)
#  oauth_access_token_id :integer
#  expire_at             :datetime
#  scopes                :string(255)
#  deleted_at            :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :api_token do
    member
    scopes 'all'
  end
end
