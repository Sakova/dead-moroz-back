class AssessmentPolicy < ApplicationPolicy
  attr_reader :user, :assessment

  def initialize(user, assessment)
    @user = user
    @assessment = assessment
  end

  def create?
    user.elf?
  end

  def update?
    user.elf?
  end
end
