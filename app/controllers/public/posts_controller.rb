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
      redirect_to new_post_path
    else
      # 条件を指定して初めの1件を取得し1件もなければ作成
      @post = Post.find_or_create_by(user_id: current_user.id, status: false)
      @post.routes.build
      # @post.idに紐づいたrouteを全て持ってくる
      @routes = Route.where(post_id: @post.id)
      render :new
    end
  end

  def index

  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    # @lat = @post.spot.latitude
    # @lng = @post.spot.longitude
    # gon.lat = @lat
    # gon.lng = @lng
  end

  def edit

  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = 'Post created!'
      redirect_to new_post_path
    else
      # 条件を指定して初めの1件を取得し1件もなければ作成
      @post = Post.find_or_create_by(user_id: current_user.id, status: false)
      @post.routes.build
      # @post.idに紐づいたrouteを全て持ってくる
      @routes = Route.where(post_id: @post.id)
      render :new
    end

  end

  def destroy
    # 指定したrouteの削除
    Route.find(params[:id]).destroy
    redirect_to new_post_path
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
