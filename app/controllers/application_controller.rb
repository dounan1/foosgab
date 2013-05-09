class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
 
  rescue_from CanCan::AccessDenied do |e|
    redirect_to root_url, alert: e.message
  end

  private

  def current_user
    @current_user ||= Player.find(session[:player_id]) if session[:player_id]
  end
  helper_method :current_user
end