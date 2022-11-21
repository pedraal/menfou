# frozen_string_literal: true

class UsersController < ApplicationController
  include Secured

  before_action :set_user, only: %i[edit update destroy follow unfollow]
  before_action :redirect_if_exists, only: %i[new create]
  before_action :authorize, only: %i[edit update destroy]

  # GET /users/search
  def search
    @users = User.where("fuzzy_handle LIKE '%#{User.cleanHandle(params[:q])}%'")
  end

  # GET /users/1
  def show
    @user = User.includes(:posts).find(params[:id])
    @follow = Follow.find_by(follower: current_user, followee: @user)
    @posts = @user.posts.order(id: :desc).page(params[:page])
  end

  # GET /users/1/followers
  def followers
    @user = User.includes(followers: :follower).find(params[:id])
    @follow = Follow.find_by(follower: current_user, followee: @user)
    @follower_users = @user.follower_users.order(id: :desc).page(params[:page])
  end

  # GET /users/1/followees
  def followees
    @user = User.includes(followees: :followee).find(params[:id])
    @follow = Follow.find_by(follower: current_user, followee: @user)
    @followee_users = @user.followee_users.order(id: :desc).page(params[:page])
  end

  # GET /users/new
  def new
    @user = User.new(handle: session[:userinfo]['nickname'])
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params.merge(auth0_id: session[:userinfo]['sub']))

    respond_to do |format|
      if @user.save
        format.html { redirect_to posts_url, notice: t('.success') }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: t('.success') }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy

    reset_session

    respond_to do |format|
      format.html { redirect_to root_url, notice: t('.success') }
    end
  end

  # PATCH/PUT /users/1
  def follow
    Follow.create!(follower: current_user, followee: @user)

    redirect_back fallback_location: user_url(@user), notice: t('.success', handle: @user.handle)
  end

  # PATCH/PUT /users/1
  def unfollow
    follow = Follow.find_by!(follower: current_user, followee: @user)
    follow.destroy!

    redirect_back fallback_location: user_url(@user), notice: t('.success', handle: @user.handle)
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:handle)
  end

  def redirect_if_exists
    redirect_to user_url(current_user) if current_user
  end

  def authorize
    return if @user == current_user

    redirect_back fallback_location: root_path
  end
end
