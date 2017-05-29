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

class Token::Activation < ::Token
  after_create :send_token

  def confirm!
    super
    member.active!
  end

  private

  def send_token
    TokenMailer.activation(member.email, token).deliver
  end
end
