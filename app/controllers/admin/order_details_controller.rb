class Admin::OrderDetailsController < ApplicationController

  before_action :authenticate_admin!

  
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find(@order_detail.order_id)
    @order_details = @order.order_details
    @order_detail.update(making_status: params[:order_detail][:making_status])
    if
      params[:order_detail][:making_status] == "manufacturing"
      @order_detail.order.update(order_status: "making")
    elsif
      @order_details.count == @order_details.where(making_status: "finish").count
      @order_detail.order.update(order_status: "preparing")
    end
      redirect_to request.referer
  end


  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end



