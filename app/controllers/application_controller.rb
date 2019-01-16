class ApplicationController < ActionController::Base
  before_filter :store_current_location, :unless => :devise_controller?
  
  include Pundit

 
  
  # Manage Pundit Errors
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Set layout
  layout :layout_by_resource

  protected
    # set layout to devise
    def layout_by_resource
      if devise_controller? && resource_name == :admin
        "backoffice_devise"
      elsif devise_controller? && resource_name == :member
        "site_devise"
      else
        "application"
      end
    end
    # devise route's config
    def after_sign_in_path_for(resource)
      stored_location = stored_location_for(resource) 
      if devise_controller? && resource_name == :member && stored_location.match(site_ad_detail_index_path)
        stored_location      
      elsif devise_controller? && resource_name == :member
        site_profile_dashboard_index_path
      else
        backoffice_path
      end
    end

    def user_not_authorized
      flash[:alert] = "Você não está autorizado a fazer essa ação."
      redirect_to(request.referrer || root_path)
    end
  
  private
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
    end

    def store_current_location
      # :user is the scope we are authenticating
      store_location_for(:member, request.url)
    end
end
