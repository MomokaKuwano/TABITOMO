class Public::PacksController < ApplicationController
  before_action :ensure_login_user, only: %i[show]

  def index
    @packs = current_user.packs.all
    @pack = Pack.new
  end

  def create
    # Transaction 開始
    @pack = Pack.new(pack_params)
    @pack.user_id = current_user.id
    # 空のitem作成
    @items = []
    # hashのeach文でitemのnameを保存する
    if params[:pack][:packing_lists_attributes] != nil
      params[:pack][:packing_lists_attributes].each do |k, v|
        @items << Item.find_or_create_by(name: v[:item][:name], user_id: current_user.id)
      end
      # @pack.packing_listsに新しいitem_idを持ったPackingListを生成する
      @items.each do |item|
        @pack.packing_lists << PackingList.new(item_id: item.id)
      end
    end

    # フォームで作られたPackとPackingListを同時に保存する
    if @pack.save
      flash[:success] = "Saved Packing!"
      redirect_to pack_path(Pack.last)
    else
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
    @pack = Pack.find(params[:id])
  end

  def update
    @pack = Pack.find(params[:id])
    @update_items = []
    if params[:pack][:packing_lists_attributes] != nil
      params[:pack][:packing_lists_attributes].each do |k, v|
        if v[:_destroy] == "false"
          @update_items << Item.find_or_create_by(name: v[:item][:name], user_id: current_user.id)
        end
      end
      @pack.packing_lists.destroy_all
      @update_items.each do |item|
        @pack.packing_lists << PackingList.new(item_id: item.id)
      end
    end
    if @pack.update(pack_params)
      redirect_to pack_path(@pack.id)
    else
      render :edit
    end
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

  # ログインしているユーザーが他のユーザーの登録情報をみれないようにする
  def ensure_login_user
     @pack = Pack.find(params[:id])
    unless @pack.user_id == current_user.id
      redirect_to root_path
    end

  end

end
