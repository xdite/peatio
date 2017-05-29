# == Schema Information
#
# Table name: tokens
#
#  id         :integer          not null, primary key
#  token      :string(255)
#  expire_at  :datetime
#  member_id  :integer
#  is_used    :boolean          default(FALSE)
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Token::Activation do
  let(:member) { create :member }
  let(:activation) { create :activation, member: member }

  describe '#confirm!' do
    before { activation.confirm! }

    it { expect(member).to be_activated }
  end

  describe 'send_token after creation' do
    let(:mail) { ActionMailer::Base.deliveries.last }

    before { activation }

    it { expect(mail.subject).to match('Account Activation') }
  end

end
