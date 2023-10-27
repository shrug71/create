class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cafe
  has_many :order_menus #added 
  has_many :menus, :through => :order_menus #added


  accepts_nested_attributes_for :order_menus


  enum status: { pending: "pending", accepted: "accepted", rejected: "rejected", confirmed: "confirmed", canceled: "canceled"}

end