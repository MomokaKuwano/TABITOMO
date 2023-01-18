class Public::PacksController < ApplicationController
  def index
    @pack = Pack.new
    @packs = Pack.all
    @item = Item.new
    @items = Item.all
    # @items = current_user.items
    @item_id = @items.pluck(:id)

    # @pack = Pack.new(pack_params)
    # if @pack.save!
    #   @item_id.each do |item_id|
    #     @pack.packing_lists.new(item_id: item.id)
    #     if packing_list.save!

    #     else

    #     end
    #   end
    # else

    # end
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

  # def pack_params
  #   params.require(:pack).permit(:title)
  # end

	def item_params
	  params.require(:item).permit(:item)
	end


end
