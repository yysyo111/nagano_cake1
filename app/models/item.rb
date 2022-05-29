class Item < ApplicationRecord

  has_one_attached :image

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
  belongs_to :genre

  with_options presence: true do
    validates :image
    validates :name
    validates :introduction
    validates :tax_excluded_price
    validates :sales_status
    validates :genre_id
  end

  validates :tax_excluded_price, numericality: {greater_than: 50}

  def tax_included_price
    (tax_excluded_price * 1.1).floor
  end

  enum sales_status: { sale: true, stop_selling: false }

  def get_item_image(size)
    image.variant(resize: size).processed
  end


end

