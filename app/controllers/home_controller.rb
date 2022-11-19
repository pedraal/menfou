class HomeController < ApplicationController
  def index
    redirect_to posts_url if user_signed_in?
    @posts_count = Post.count
  end
end
