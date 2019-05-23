class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    # ???? how to compare current station the station the user is on????
    true
    # user.bookings.each do |booking|
    #   raise
    #   booking.station_id == record.id && booking.confirmed ? true : false
    # end

  end

  def new?
    true
  end
end
