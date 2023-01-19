class Public::PacksController < ApplicationController
  def index
    @item = Item.new
    @items = current_user.items
    @item_id = @items.pluck(:id)
    @packs = current_user.packs
    @pack = Pack.new
  end

  def create
    @pack = Pack.new(pack_params)
    if @pack.save!
      @item_id.each do |item_id|
      @pack.packing_lists.new(item_id: item.id)
      if packing_list.save!
        # flash
        render :index
      elses
        # flash
        render :index
      end
    end
    else
      # flash
      render :index
    end
  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def pack_params
    params.require(:pack).permit(:pack_title).merge(user_id: current_user.id)
  end


end
