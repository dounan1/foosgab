class AuthController < ApplicationController
  def google
    player = Player.where(uid: request.env["omniauth.auth"][:uid]).first
    
    if player.present?
      player.email ||= request.env['omniauth.auth'][:info][:email]
      player.avatar_url ||= request.env['omniauth.auth'][:info][:image]
      player.save
      session[:player_id] = player._id
      redirect_to root_url, notice: "You signed in! Here's a cookie."
    else
      session[:uid] = request.env["omniauth.auth"][:uid]
      redirect_to claim_player_path
    end
  end

  def claim
    @players = Player.where(uid: nil)
    flash[:notice] = "Thanks for signing in! Claim your player record to continue."
  end

  def finish
    player = Player.find(params[:player_id])
    player.update_attribute(:uid, session[:uid]) and session.delete(:uid)
    flash[:success] = "Welcome to Foosgab, #{player.name}! Your account is now claimed."
    redirect_to root_path
  end
end