class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  def update
  end

  # 製作ステータス
  enum making_status: {impossible_manufacture:0, waiting_manufacture:1, manufacturing:2, finish:3}

  def subtotal # 小計
    self.price * self.quantity
  end

  private

  def params_order_detail
    params.require(:order_detail).permit(:order_id, :item_id, :price, :quantity, :making_status)
  end
end
