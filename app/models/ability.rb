class Ability
  include CanCan::Ability
  #
  # => administrator  -> full access for all actions
  # => moderator -> full acces for articles and comments
  # => author + member -> Can write and edit their articles
  # => member -> Can add comments, change their profile
  # => guest -> Can read articles and comments
  def initialize(user)
    alias_action :finish_signup, :to => :update
    user ||= User.new
    #ADMINSTRATOR: all_resouces(all actions)
    if user.role? :administrator
      can :manage, :all
    end
    # MODERATOR: Article(all actions), Comment(all actions)
    if user.role? :moderator
        can :manage, Article
        #can :manage, Comment
    end
    # AUTHOR: Article(create, update, destroy)
    if user.role? :author
        can [:update, :destroy], Article do |x|
            x.try(:author) == user
        end
        can [:create], Article
    end
    # MEMBER: Article(read), User(read, self.read, self.update)
    if user.role? :member
        can :read, Article
        can :read, User
        can :update, User do |x|
            x.try(:id) == user.id
        end
        can :finish_signup, User
       #can :read, Comment
       #can [:create,:update], Comment, user: user
    end
    #GUEST: all(read)
    if user.role? :guest
        can :read, Article
        can :read, User
        #can :read, Comment
    end
    # BANNED: User(self.show)
    if user.role? :banned
        cannot :manage, :all
        can :show, User do |x|
            x.try(:id) == user.id
        end
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
