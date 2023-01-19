class Public::ItemsController < ApplicationController

  def create
    @items = current_user.items
    @packs = current_user.packs
    @item = Item.new(item_params)
    if @item.save!
      redirect_to packs_path
    else
      render template: "public/packs/index"
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(update_item_params)
      redirect_to packs_path
    else
      @items = current_user.items
      @packs = current_user.packs
      render template: "public/packs/index"
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to packs_path
  end

  private

  def item_params
	  params.require(:item).permit(:name).merge(user_id: current_user.id)
  end

  def update_item_params
    params.require(:item).permit(:name)
  end

end
