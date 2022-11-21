# frozen_string_literal: true

class PostsController < ApplicationController
  include Secured

  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize, only: %i[edit update destroy]

  # GET /posts
  def index
    @posts = Post.where(user: current_user.followee_users).or(Post.where(user: current_user)).order(id: :desc).page(params[:page])
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: t('.success') }
        format.turbo_stream { render turbo_stream: turbo_stream.remove('new-post-modal') }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: t('.success') }
        format.turbo_stream { render turbo_stream: turbo_stream.remove('edit-post-modal') }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: t('.success') }
      format.turbo_stream
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:body)
  end

  def authorize
    return if @post.user == current_user

    redirect_back fallback_location: root_path
  end
end
