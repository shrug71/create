class Menu < ApplicationRecord
  has_many :orders, through: :order_menus
  has_many :cafes, through: :cafe_menus
  belongs_to :cafe, class_name:"Cafe" , dependent: :destroy
end


