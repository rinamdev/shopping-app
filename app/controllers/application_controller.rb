class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :update_allowed_parameters, if: :devise_controller?

  def after_sign_in_path_for(user)
    if user.role == true
      products_path
    else
      root_path
    end
  end
  
  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :address_1, :address_2, :city, :state, :postal_code, :role)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :address_1, :address_2, :city, :state, :postal_code, :role, :current_password)}
  end
end
