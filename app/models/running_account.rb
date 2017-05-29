# == Schema Information
#
# Table name: running_accounts
#
#  id          :integer          not null, primary key
#  category    :integer
#  income      :decimal(32, 16)  default(0.0), not null
#  expenses    :decimal(32, 16)  default(0.0), not null
#  currency    :integer
#  member_id   :integer
#  source_id   :integer
#  source_type :string(255)
#  note        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class RunningAccount < ActiveRecord::Base
  include Currencible

  CATEGORY = {
    withdraw_fee:         0,
    trading_fee:          1,
    register_reward:      2,
    referral_code_reward: 3,
    deposit_reward:       4
  }

  enumerize :category, in: CATEGORY

  belongs_to :member
  belongs_to :source, polymorphic: true

end
