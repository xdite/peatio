# == Schema Information
#
# Table name: signup_histories
#
#  id              :integer          not null, primary key
#  member_id       :integer
#  ip              :string(255)
#  accept_language :string(255)
#  ua              :string(255)
#  created_at      :datetime
#

class SignupHistory < ActiveRecord::Base

end
