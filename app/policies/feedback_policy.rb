class FeedbackPolicy < ApplicationPolicy
  attr_reader :user, :feedback

  def initialize(user, feedback)
    @user = user
    @feedback = feedback
  end

  def create?
    user.elf?
  end

  def update?
    user.elf?
  end
end
