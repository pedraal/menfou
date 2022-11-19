module Insecured
  extend ActiveSupport::Concern

  included do
    before_action :not_logged_in_using_omniauth?
  end

  def not_logged_in_using_omniauth?
    redirect_to '/' if user_signed_in?
  end
end
