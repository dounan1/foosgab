class Ability
  include CanCan::Ability

  DOMAIN_WHITELIST = ['givegab.com', 'iyouvo.com']

  def initialize(player)
    player ||= Player.new
    
    if player.email && DOMAIN_WHITELIST.include?(player.email.split('@')[1])
      can :manage, :all
    else
      can :read, :all
    end
  end

end