# frozen_string_literal: true

class PostsController < ApplicationController
  include Secured

  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize, only: %i[edit update destroy]
  before_action :authorize_show, only: %i[show]
  before_action :set_parent, only: %i[create]
  before_action :authorize_create_reply, only: %i[create]

  # GET /posts
  def index
    @posts = Post.not_replies.where(user: current_user.followee_users).or(Post.not_replies.where(user: current_user)).order(id: :desc).page(params[:page])
    @top_posters = User.order(posts_count: :desc).limit(3)
    @top_followers = User.order(followers_count: :desc).limit(3)
  end

  # GET /posts/1
  def show
    authorize_show

    @reply = Post.new(parent: @post)
    @replies = @post.replies.order(id: :desc).page(params[:page])
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
    authorize_create_reply

    @post = Post.new(post_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: t('.success') }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render (@post.parent ? :show : :new), status: :unprocessable_entity }
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

  def set_parent
    return unless post_params[:parent_id].present?

    @parent = Post.find(post_params[:parent_id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:body, :parent_id)
  end

  def authorize
    return if @post.user == current_user

    redirect_back fallback_location: root_path
  end

  def authorize_show
    return if @post.parent.nil?

    redirect_back fallback_location: root_path
  end

  def authorize_create_reply
    return unless @parent&.parent

    redirect_to @parent
  end
end
