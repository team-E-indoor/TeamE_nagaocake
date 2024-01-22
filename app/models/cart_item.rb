class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  
  def subtotal
    item.with_tax_price * amount
  end

  def with_tax_price
    (price * 1.1).floor
  end

end
