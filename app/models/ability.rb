# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all

    if user.persisted?
      can :manage, Post
      can :like, Post
      can :destroy, Post, author_id: user.id
      can :destroy, Comment, user_id: user.id
    end

    if user.admin?
      can :manage, :all
    end
  end
end
