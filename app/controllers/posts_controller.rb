class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :new]

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(post_params)
    @post.user_id = @current_user.id
    if @post.save
      flash[:success] = "New post has been successfully created."
      redirect_to posts_path
    else
      flash.now[:error] = "Couldn't create new post."
      render 'new'
    end
  end

  def index
  	@posts = Post.all
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:error] = "You need to be logged in to do that"
  	  redirect_to login_url
    end
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
