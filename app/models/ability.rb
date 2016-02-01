class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? :admin
      can :manage, :all
    end
    if user.role? :moderator
        can :manage, Article
        #can :manage, Comment
    end
    if user.role? :writer
        can [:update, :destroy], Article do |x|
            x.try(:author) == user
        end
        can [:create], Article
    end
    if user.role? :reader
        can :read, Article
       #can :read, Comment
       #can [:create,:update], Comment, user: user
    end
    if user.new_record?
        can :read, Article
        #can :read, Comment
    end
    

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
