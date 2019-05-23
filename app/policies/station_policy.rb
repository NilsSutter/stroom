class StationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def new?
    true
  end

  def update?
    edit?
  end

  def edit?
    record.user == user || is_user_admin?
  end

  def show?
    true
  end

  def index?
    true
  end

  def destroy?
    record.user == user || is_user_admin?
  end

  def delete_photo?
    destroy?
  end

  private

  def is_user_admin?
    current_user.admin
  end
end
