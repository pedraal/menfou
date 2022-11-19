class UsersController < ApplicationController
  include Secured

  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :redirect_if_exists, only: %i[ new create ]

  # GET /users/1
  def show
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
    @user = User.new(user_params.merge(
      auth0_id: session[:userinfo]['sub'],
      auth0_data: session[:userinfo]))

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
        format.html { redirect_to user_url(@user), notice: t(".success") }
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
end