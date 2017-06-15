class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.role == "admin"
      can :read, :all
      cannot [:create, :update], Feedback
      cannot :manage, Product
      can :create, [CommentProduct, Likeship, Relationship, Category]
      can :manage, [CommentProduct, Feedback, User, Category]
      can :destroy, :all
    end
    if user.sale?
      can :manage, [CommentProduct, Product]
      can :create, Feedback
      cannot :manage, User
      cannot :manage, Category
      can [:read, :create, :destroy], Relationship
      can [:create, :destroy], Likeship
    end
    if user.buy?
      can :read, Product
      can [:read, :create, :destroy], Relationship
    end
  end
end
