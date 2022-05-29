class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items= current_customer.cart_items
    @cart_item = CartItem.new
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to request.referer, notice: "数量が変更されました"
    end
  end

  def create
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.total_count += params[:cart_item][:total_count].to_i
      @cart_item.save
      redirect_to cart_items_path, notice: "カートに商品が追加されました"
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.save
      redirect_to cart_items_path
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.delete
    redirect_to request.referer, notice: "カートから商品が削除されました"
  end

  def all_destroy
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:total_count, :item_id, :customer_id)
  end

end


