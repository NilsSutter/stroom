class BookingsController < ApplicationController

  def create
    @new_booking = Booking.new(params_create_booking)
    @station = Station.find(params[:station_id])
    @new_booking.user = current_user
    @new_booking.station = @station

    authorize @new_booking

    if @new_booking.save
      flash[:alert] = "Booking Created!"
      redirect_to station_path(@station)
    else
      render './stations/show'
    end
  end

  private

  def params_create_booking
    params.require(:booking).permit(:start, :end)
  end
end
