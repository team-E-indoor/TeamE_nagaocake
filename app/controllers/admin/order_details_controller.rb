class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)
    if  @order_detail.making_status == "manufacturing"
      @order.update(status: "in_making")
    end

    if @order.order_details.all?{|order_detail| order_detail.making_status == "finish"}
      @order.update(status: "preparing_delivery")
    else
       @order.update(status: "in_making")
    end
    redirect_to admin_order_path(@order)
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
