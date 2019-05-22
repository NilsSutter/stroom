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
    true
    # (record.user == user && user.owner) || is_user_admin?
  end

  def show?
    true
  end

  def index?
    true
  end

  def destroy?
    true
    # (record.user == user && user.owner) || is_user_admin?
  end

  def delete_photo?
    destroy?
  end

  private

  def is_user_admin?
    current_user.admin
  end
end
