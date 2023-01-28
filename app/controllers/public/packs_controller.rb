class Public::PacksController < ApplicationController

  def index
    @packs = current_user.packs.all
    @pack = Pack.new
  end

  def create
    # 空のitem作成
    @items = []
  # Transaction 開始
    @pack = Pack.new(pack_params)
    @pack.user_id = current_user.id
    # hashのeach文でitemのnameを保存する
    if params[:pack][:packing_lists_attributes] != nil
      params[:pack][:packing_lists_attributes].each do |k, v|
        @items << Item.find_or_create_by(name: v[:item][:name], user_id: current_user.id)
      end
    end

    # @pack.packing_listsに新しいitem_idを持ったPackingListを生成する
    @items.each do |item|
      @pack.packing_lists << PackingList.new(item_id: item.id)
    end
    # フォームで作られたPackとPackingListを同時に保存する
    if @pack.save
  # Transaction commit
      flash[:success] = "Saved Packing!"
      redirect_to pack_path(Pack.last)
    else
  # Transaction rollback
      @packs = current_user.packs.all
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
    flash[:success] = "Successfully removed packing!"
    redirect_to packs_path
  end

  private

  def pack_params
    params.require(:pack).permit(:pack_title)
  end


end
