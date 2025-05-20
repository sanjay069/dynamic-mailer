class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    if user.role == "admin"
      can :manage, :all
    elsif user.role == "Consumer"
      can :read, Template
      can :read, Language, status: "enable"
    end
  end
end
