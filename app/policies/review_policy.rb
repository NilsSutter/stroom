class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.station.user != user && record.booking.user == user
  end

  def new?
    true
  end
end
