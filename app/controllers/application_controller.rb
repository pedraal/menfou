# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :load_auth_info

  def user_signed_in?
    @auth_info.presence
  end
  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find_by(auth0_id: @auth_info && @auth_info['sub'])
  end
  helper_method :current_user

private

  def load_auth_info
    # session[:userinfo] was saved earlier on Auth0Controller#callback
    @auth_info = session[:userinfo]
  end
end
