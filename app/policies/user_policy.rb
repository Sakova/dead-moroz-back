class UserPolicy < ApplicationPolicy
  attr_reader :user

  def initialize(user)
    @user = user
  end

  class Scope < Scope
    def resolve
      scope.all if user.elf? || user.dead?
    end
  end
end
