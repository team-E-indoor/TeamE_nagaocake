class Public::ItemsController < ApplicationController
  def index
  end

  def show
    @cart_item = CartItem.new
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image, :customer_id, :item_id)
  end

end
