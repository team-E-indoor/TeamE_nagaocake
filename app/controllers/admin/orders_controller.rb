class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_status = @order.statusｃ
    @order_details = OrderDetail.where(order_id: params[:id])
  end
  
  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(order_params)
    if order.status == "payment_confirmation"
      @order_details.each do |order_detail|
        oder_detail.update(making_status: 1)
      end
    end
    if order.update(order_params)
      @order_details.update_all(making_status: "制作待ち") if @order.status == "入金確認"
    end
    　redirect_to admin_order_path(order.id), notice: "変更を完了しました"
  end
  
  private

  def order_params
    params.require(:order).permit(:customer_id, :post_code, :address, :name, :shipping_cost, :total_price, :payment_method, :status)
  end
end
