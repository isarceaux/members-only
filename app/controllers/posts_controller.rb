class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]


  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.author = current_user.name
    if @post.save
      flash[:success] = "the post was successfully submitted !"
      redirect_to root_path
    else
      flash[:danger] = "the post wasn't submitted"
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  private

    def post_params
        params.require(:post).permit(:content)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

end
