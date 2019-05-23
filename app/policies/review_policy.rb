class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    # "i can create a review if i am not owner and i booked the station"

    record.station.user != user && user.bookings.include?(record.booking)
  end

  def new?
    true
  end
end
