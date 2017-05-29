# == Schema Information
#
# Table name: payment_transactions
#
#  id            :integer          not null, primary key
#  txid          :string(255)
#  amount        :decimal(32, 16)
#  confirmations :integer
#  address       :string(255)
#  state         :integer
#  aasm_state    :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  receive_at    :datetime
#  dont_at       :datetime
#  currency      :integer
#  type          :string(60)
#  txout         :integer
#

class PaymentTransaction < ActiveRecord::Base
  extend Enumerize

  include AASM
  include AASM::Locking
  include Currencible

  STATE = [:unconfirm, :confirming, :confirmed]
  enumerize :aasm_state, in: STATE, scope: true

  validates_presence_of :txid

  has_one :deposit
  belongs_to :payment_address, foreign_key: 'address', primary_key: 'address'
  has_one :account, through: :payment_address
  has_one :member, through: :account

  after_update :sync_update

  aasm :whiny_transitions => false do
    state :unconfirm, initial: true
    state :confirming, after_commit: :deposit_accept
    state :confirmed, after_commit: :deposit_accept

    event :check do |e|
      before :refresh_confirmations

      transitions :from => [:unconfirm, :confirming], :to => :confirming, :guard => :min_confirm?
      transitions :from => [:unconfirm, :confirming, :confirmed], :to => :confirmed, :guard => :max_confirm?
    end
  end

  def min_confirm?
    deposit.min_confirm?(confirmations)
  end

  def max_confirm?
    deposit.max_confirm?(confirmations)
  end

  def refresh_confirmations
    raw = CoinRPC[deposit.currency].gettransaction(txid)
    self.confirmations = raw[:confirmations]
    save!
  end

  def deposit_accept
    if deposit.may_accept?
      deposit.accept! 
    end
  end

  private

  def sync_update
    if self.confirmations_changed?
      ::Pusher["private-#{deposit.member.sn}"].trigger_async('deposits', { type: 'update', id: self.deposit.id, attributes: {confirmations: self.confirmations}})
    end
  end
end
