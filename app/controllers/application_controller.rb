class ApplicationController < ActionController::Base

  private

  def authenticate_admin!
    redirect_to root_path unless current_user&.is_website_administrator?
  end

end
