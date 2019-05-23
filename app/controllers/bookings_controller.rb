class BookingsController < ApplicationController

  def index
    @bookings = policy_scope(Booking)
    @stations = Station.where(user_id: current_user.id)
  end

  def create
    @new_booking = Booking.new(params_create_booking)
    @station = Station.find(params[:station_id])
    @new_booking.user = current_user
    @new_booking.station = @station
# if statement außenrum bauen vllt? ändert sich zumindest der error nicht
    # unless @new_booking.user_id == current_user.id
      if @new_booking.save
        flash[:alert] = "Booking Created!"
        redirect_to station_path(@station)
        authorize @new_booking
      else
        render './stations/show'
      end
    # end
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
