class Role < ApplicationRecord
  has_many :users  # A role can have many users

  enum name: { admin: 'admin', cafeowner: 'cafeowner', customer: 'customer' }
end
