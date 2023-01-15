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

  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    
  end
  
  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to packs_path
  end

  private

	def item_params
	  params.require(:item).permit(:item)
	end


end
