class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
 
  private

  def current_user
    @current_user ||= Player.find(session[:player_id]) if session[:player_id]
  end
  helper_method :current_user
end