class Public::PacksController < ApplicationController

  def index

    @packs = current_user.packs.all
    @pack = Pack.new
  end

  def create
    # 空のitem作成
    @items = []
    # hashのeach文でitemのnameを保存する
    params[:pack][:packing_lists_attributes].each do |k, v|
      @items << Item.find_or_create_by(name: v[:item_id], user_id: current_user.id)
    end
    @pack = Pack.new(pack_params)
    @pack.user_id = current_user.id
    if @pack.save
      # packingリストにそれぞれのidを保存
      @items.each do |item|
        PackingList.create(pack_id: @pack.id, item_id: item.id)
      end
      redirect_to pack_path(Pack.last)
    else
      render :index
    end
  end

  def show
    @pack = Pack.find(params[:id])
    # item_ids = @pack.packing_lists.pluck(:item_id)
    @items = @pack.items
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

  # def pack_params
  #   params.require(:pack).permit(:pack_title).merge(user_id: current_user.id)
  # end
  def pack_params
    params.require(:pack).permit(:pack_title)
    #   packing_lists_attributes: [:id, :item_id, :name, :_destroy]
    # )
  end


end
