class StationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    new?
  end

  def new?
    true || is_user_admin?
  end

  def update?
    edit?
  end

  def edit?
    true || is_user_admin?
  end

  def show?
    true
  end

  def index?
    true
  end

  def destroy?
    true || is_user_admin?
  end

  private

  def is_user_admin?
    current_user.admin
  end
end
