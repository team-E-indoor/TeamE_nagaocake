class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_status = @order.status
    @order_details = @order.order_details
  end
  
  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(order_params)
    if order.status == "confirm_payment"
      @order_details.each do |order_detail|
        oder_detail.update(making_status: 1)
      end
    end
    　redirect_to admin_order_path(order.id), notice: "変更を完了しました"
  end
  
  private

  def order_params
    params.require(:order).permit(:customer_id, :post_code, :address, :name, :shipping_cost, :total_price, :payment_method, :status)
  end
end
