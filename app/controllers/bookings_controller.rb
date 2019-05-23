class BookingsController < ApplicationController

  def index
    @bookings = Booking.where(user_id: params[:user_id])

    authorize @bookings
  end

  def create
    @booking = Booking.new(params_create_booking)
    @station = Station.find(params[:station_id])
    @booking.user = current_user
    @booking.station = @station

    authorize @booking

    if @booking.save
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
