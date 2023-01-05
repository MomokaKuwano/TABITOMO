class Public::PacksController < ApplicationController
  def index
    @pack = Pack.new
    @item = Item.new
    @items = Item.all
  end

  def create
  　@item = Item.new(item_params)

    if @item.save
       redirect_to packs_path
    else
      render :index
    end
  end

  def show

  end

  private

	def item_params
	  params.require(:item).permit(:item)
	end


end
