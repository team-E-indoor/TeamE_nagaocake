class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    # rails active_storage:installのコマンドした。ジャンル作ったら@item.genre_id = 1消す
    @item.genre_id = 1
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end


  def index
  end

  def show
  end

  def edit
    @item = Item.find(params[:id])
  end
  
  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :item_description, :price, :is_active, :image )
  end

end
