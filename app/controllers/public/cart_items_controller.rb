class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.subtotal }
  end

  def update
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.update_attribute(:amount, cart_item_params[:amount])
    redirect_to cart_items_path
  end

  def destroy
    cart_item = current_customer.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id

    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      @cart_item.amount += params[:cart_item][:amount].to_i

      @cart_item.save
      redirect_to cart_items_path

    elsif @cart_item.save
      @cart_items = current_customer.cart_items.all
      redirect_to cart_items_path
    else
      render 'index'
    end

  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :price)
  end

end
