class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  rescue_from ActionController::InvalidAuthenticityToken, with: :handle_unverified_request

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u| u.permit(:name, :email, :password,
                                                                :business_permit_attributes => [:permit_number])
    end

    devise_parameter_sanitizer.permit(:account_update) do |u| u.permit(:name, :email, :password, :current_password,
                                                                       :business_permit_attributes => [:permit_number])
    end
  end

  def handle_unverified_request
    flash[:notice] = 'Kindly retry.'
    redirect_to store_index_url
  end

end
