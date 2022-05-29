class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy
  has_many :items, through: :order_details

  validates :name, presence: true
  validates :post_code, presence: true, length: { is: 7 }
  validates :address, presence: true

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { wait_payment: 0, confirm_payment: 1, making: 2, preparing: 3, shipped: 4 }

end
