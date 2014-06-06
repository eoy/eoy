class PostPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end

    def initialize(user, post)
      @user = user
      @post = post
    end

    def update?
      raise @user.roles
      @user.has_role?(:admin)
    end

    def show?
      true
    end
  end
end
