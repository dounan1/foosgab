class SessionsController < ApplicationController

  def create
    player = Player.where(uid: env['omniauth.auth'][:uid])
    session[:player_id] = player._id
    redirect_to root_url, notice: "You signed in! Here's a cookie."
  end

  def destroy
    session[:player_id] = nil
    redirect_to root_url, notice: "Signed out."
  end

end