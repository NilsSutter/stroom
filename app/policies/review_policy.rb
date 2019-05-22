class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

    def create?
      new?
    end

    def new?
      true
      # ???? how to compare current station the user is on????

      # validation_arr = []
      # user.bookings.each do |booking|
      #   if booking.station_id == record.id && booking.confirmed
      #     validation_arr << booking
      #   end
      # end
      # validation_arr.size.positive?
    end
end
