class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: [:home, :index, :show], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: [:home, :index, :show], unless: :skip_pundit?


  #rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  #def user_not_authorized
  #  flash[:alert] = "You are not authorized to perform this action."
  #  redirect_to(root_path)
  #end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end
