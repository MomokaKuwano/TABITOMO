class Public::PostsController < ApplicationController
  def new
    # 条件を指定して初めの1件を取得し1件もなければ作成
    @post = Post.find_or_create_by(user_id: current_user.id, status: false)
    @post.routes.build
    @route = Route.new
    # @post.idに紐づいたrouteを全て持ってくる
    @routes = Route.where(post_id: @post.id)
  end

  def create
    @route = Route.new(route_params)
    if @route.save
      if params[:update_add]
        redirect_to edit_post_path(route_params[:post_id])
      else
        redirect_to new_post_path
      end
    else
      # 条件を指定して初めの1件を取得し1件もなければ作成
      @post = Post.find_or_create_by(user_id: current_user.id, status: false)
      @post.routes.build
      # @post.idに紐づいたrouteを全て持ってくる
      @routes = Route.where(post_id: @post.id)
      render :new
    end
  end

  def update
    # 通常 : Postの下書きまたは投稿
    # params[:update_route]があれば : ルートの更新
    if params[:update_route]
      # ルート更新
      @route = Route.find(params[:route_id])
      @route.update(route_params)
      redirect_to edit_post_path(params[:id])
    else
      # Postの下書きまたは投稿
      @post = Post.find(params[:id])
      if @post.update(post_params)
        flash[:success] = 'Post created!'
        redirect_to post_path(@post)
      else
        # 条件を指定して初めの1件を取得し1件もなければ作成
        @post = Post.find_or_create_by(user_id: current_user.id, status: false)
        @post.routes.build
        # @post.idに紐づいたrouteを全て持ってくる
        @routes = Route.where(post_id: @post.id)
        render :new
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
    @route = Route.new
    @routes = Route.where(post_id: @post.id)
  end

  def edit_detail
    @post = Post.find(params[:post_id])
    @route = Route.find(params[:route_id])
    @routes = Route.where(post_id: @post.id)
  end

  def destroy
    # 指定したrouteの削除
    Route.find(params[:route_id]).destroy
    if params[:edit]
      redirect_to edit_post_path(params[:id])
    else
      redirect_to new_post_path
    end
  end

  private

	def route_params
	  params.require(:route).permit(:post_id, :latitude, :longitude, :spot, :date, :time, :image, :caption)
	end

	def post_params
	 # margeでpostの公開ステータスをtrueにする
	  params.require(:post).permit(:title).merge(status: true)
	end

end
