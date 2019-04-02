class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit()
      end

      devise_parameter_sanitizer.permit(:account_update) do |user_params_update|
        user_params_update.permit(
                              :email,
                              :password,
                              :password_confirmation,
                              :fname,
                              :lname,
        )
      end

    end


end
