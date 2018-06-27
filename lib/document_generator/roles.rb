require 'egov_utils/user_utils/role'

class AdminRole < EgovUtils::UserUtils::Role

  add 'admin'

  def define_abilities(ability, user)
    ability.can :manage, :all
  end

end

class AnonymousRole < EgovUtils::UserUtils::Role

  add 'anonymous'

  def define_abilities(ability, user)
    ability.can :manage, :all
  end

end
