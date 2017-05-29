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

class PaymentTransaction::Normal < PaymentTransaction
  # Default payment transaction captures all bitcoin-like transactions.

  validates_presence_of :txout
  validates_uniqueness_of :txout, scope: :txid

end
