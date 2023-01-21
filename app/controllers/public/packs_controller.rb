class Public::PacksController < ApplicationController
  def index
    @item = Item.new
    @items = current_user.items.all
    @item_id = @items.pluck(:id)
    @packs = current_user.packs.all
    @pack = Pack.new
  end

  def create
    @packs = current_user.packs.all
    @items = current_user.items.all
    @item_ids = @items.pluck(:id)
    @pack = Pack.new(pack_params)
    if @pack.save
      @item_ids.each do |item_id_data|
        @packing_list = @pack.packing_lists.new
        @packing_list.pack_id = @pack.id
        @packing_list.item_id = item_id_data
        # @packing_list = @pack.packing_lists.new(item_id: item_id_data)
        @packing_list.save
      end
      redirect_to pack_path(@pack)
    else
      # flash
      render :index
    end
  end

  def show
    @pack = Pack.find(params[:id])

    item_ids = @pack.packing_lists.pluck(:item_id)
    @items = Item.where(id: [item_ids])

    # byebug
    # @items = current_user.items
  end

  def edit

  end

  def update

  end

  def destroy
    pack = Pack.find(params[:id])
    pack.destroy
    redirect_to packs_path
  end

  private

  def pack_params
    params.require(:pack).permit(:pack_title).merge(user_id: current_user.id)
  end


end
