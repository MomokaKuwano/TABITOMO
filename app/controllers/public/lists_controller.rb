class Public::ListsController < ApplicationController
  before_action :ensure_login_user, only: %i[show]

  def index
    @packs = current_user.lists.all
    @pack = List.new
  end

  def create
    # Transaction 開始
    @pack = List.new(pack_params)
    @pack.user_id = current_user.id
    # 空のitem作成
    @items = []
    # hashのeach文でitemのnameを保存する
    if params[:list][:packing_lists_attributes] != nil
      params[:list][:packing_lists_attributes].each do |k, v|
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
      redirect_to list_path(List.last.id)
    else
      @packs = current_user.packs.all
      render :index
    end
  end

  def show
    @pack = List.find(params[:id])
    # item_ids = @pack.packing_lists.pluck(:item_id)
    @items = @pack.items
  end

  def edit
    @pack = List.find(params[:id])
  end

  def update
    @pack = List.find(params[:id])
    @update_items = []
    if params[:list][:packing_lists_attributes] != nil
      params[:list][:packing_lists_attributes].each do |k, v|
        # deleteを押すと"false"が"1"になるので"false"分だけfind_or_createする
        if v[:_destroy] == "false"
          @update_items << Item.find_or_create_by(name: v[:item][:name], user_id: current_user.id)
        end
      end
      # 一度packing_listsを全て消す
      @pack.packing_lists.destroy_all
      # 新しくpacking_listsを作る
      @update_items.each do |item|
        @pack.packing_lists << PackingList.new(item_id: item.id)
      end
    end
    if @pack.update(pack_params)
      redirect_to list_path(@pack.id)
    else
      render :edit
    end
  end

  def destroy
    pack = List.find(params[:id])
    pack.destroy
    flash[:success] = "Successfully removed packing!"
    redirect_to lists_path
  end

  private

  def pack_params
    params.require(:list).permit(:pack_title)
  end

  # ログインしているユーザーが他のユーザーの登録情報をみれないようにする
  def ensure_login_user
     @pack = List.find(params[:id])
    unless @pack.user_id == current_user.id
      redirect_to root_path
    end

  end

end
