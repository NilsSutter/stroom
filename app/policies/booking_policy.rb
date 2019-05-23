class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
    end
  end

  def create?
    record.station.user != user
  end

  def new?
    true
  end

  def destroy?
    record.user == user || user.admin
  end
end
