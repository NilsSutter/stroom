class BookingsController < ApplicationController

  def index
    @bookings = policy_scope(Booking)
  end

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

  def destroy
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def params_create_booking
    params.require(:booking).permit(:start, :end)
  end
end
