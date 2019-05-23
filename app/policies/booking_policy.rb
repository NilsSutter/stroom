class BookingPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.station.user != user
  end

  def new?
    true
  end
end
