class HomeController < ApplicationController
  include Insecured

  def index
    @posts_count = Post.count
  end
end
