class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  # has_many :itmes, through: :cart_items
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :first_name, :last_name, :first_name_kana, :last_name_kana, :post_code, :address, :phone_number, presence: true
  validates :post_code, length: { is: 7 }
  # 退会済ユーザーをブロック
  def active_for_authentication?
    super && (is_deleted == false)
  end

  def address_display_code
    '〒' + post_code + '' + address + '' + last_name + '' + first_name
  end
end
