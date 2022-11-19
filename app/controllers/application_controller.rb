class ApplicationController < ActionController::Base
  before_action :load_user

  def user_signed_in?
    @user.presence
  end
  alias_method :current_user, :user_signed_in?
  helper_method :user_signed_in?
  helper_method :current_user

  private

  def load_user
    # session[:userinfo] was saved earlier on Auth0Controller#callback
    @user = session[:userinfo]
  end
end
