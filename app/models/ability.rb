class Ability
  include CanCan::Ability

  DOMAIN_WHITELIST = ['givegab.com', 'iyouvo.com']

  def initialize(player)
    player ||= Player.new
    
    can :read, :all
    can :manage, :all if player.email && DOMAIN_WHITELIST.include?(player.email.split('@')[1])
    can :email, Player if player.persisted?
  end

end