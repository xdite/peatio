# == Schema Information
#
# Table name: orders
#
#  id             :integer          not null, primary key
#  bid            :integer
#  ask            :integer
#  currency       :integer
#  price          :decimal(32, 16)
#  volume         :decimal(32, 16)
#  origin_volume  :decimal(32, 16)
#  state          :integer
#  done_at        :datetime
#  type           :string(8)
#  member_id      :integer
#  created_at     :datetime
#  updated_at     :datetime
#  sn             :string(255)
#  source         :string(255)      not null
#  ord_type       :string(10)
#  locked         :decimal(32, 16)
#  origin_locked  :decimal(32, 16)
#  funds_received :decimal(32, 16)  default(0.0)
#  trades_count   :integer          default(0)
#

FactoryGirl.define do
  factory :order_bid do
    bid :cny
    ask :btc
    currency :btccny
    state :wait
    source 'Web'
    ord_type 'limit'
    price { '1'.to_d }
    volume { '1'.to_d }
    origin_volume { volume }
    locked { price.to_d*volume.to_d }
    origin_locked { locked }
  end

  factory :order_ask do
    bid :cny
    ask :btc
    currency :btccny
    state :wait
    source 'Web'
    ord_type 'limit'
    price { '1'.to_d }
    volume { '1'.to_d }
    origin_volume { volume }
    locked { volume }
    origin_locked { locked }
  end
end
