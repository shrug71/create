class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

 enum role: { admin: 'admin', cafeowner: 'cafeowner', customer: 'customer' }
  has_one :cafe
  
  def orders
    Order.where(user_id: id)
  end
  
  def jwt_payload
    super.merge('foo' => 'bar')
  end

  validates :email, presence: true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
end


