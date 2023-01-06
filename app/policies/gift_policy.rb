class GiftPolicy < ApplicationPolicy
  attr_reader :user, :gift

  def initialize(user, gift)
    @user = user
    @gift = gift
  end

  def create?
    user.gifts.include?(@gift) || user.elf?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  class Scope < Scope
    def resolve
      scope.where(user_id: user.id, created_by: "child") if user.user?
    end
  end
end
