class StationsController < ApplicationController
  before_action :find_station, only: [:show]
  before_action :no_user_auth_needed, only: [:home, :index, :show]
  skip_before_action :authenticate_user!, only: [:home, :index, :show, :delete_photo]

  def home
  end

  def index
    @search = params[:search]
    @charger = @search["charger"]
    @address = @search["address"]

    if @address.empty? && @charger.empty?
      @stations = Station.all

    elsif @address.empty?

      sql_query = " \ stations.charger @@ :charger"
      @stations = Station.where(sql_query, charger: @charger)

    elsif @charger.empty?

      sql_query = " \ stations.address @@ :address"
      @stations = Station.where(sql_query, address: @address)

    else
      raise
      # @start = "#{@search["start(1i)"]}-0#{@search["start(2i)"]}-#{@search["start(3i)"]} #{@search["start(4i)"]}:#{@search["start(5i)"]}:00"
      sql_query = " \ stations.address @@ :address \ AND stations.charger @@ :charger"
      @stations = Station.where(sql_query, address: @address, charger: @charger)
    end
  end

  def show
    @station = Station.find(params[:id])
    @review = Review.new
    @booking = @station.bookings.last
    @new_booking = Booking.new
  end

  def new
    @station = Station.new
    authorize @station
  end

  def create
    @station = Station.new(params_station)
    authorize @station
    # @user = current_user
    @station.user = current_user
    if @station.save
      redirect_to station_path(@station)
    else
      render :new
    end
  end

  def delete_photo
    @station = Station.find(params[:id])
    authorize @station
    @station.remove_photo!
    @station.save
    redirect_to @station
  end

  private

  def no_user_auth_needed
    @stations = policy_scope(Station)
  end

  def find_station
    @station = Station.find(params[:id])
    authorize @station
  end

  def params_station
    params.require(:station).permit(:address, :charger, :photo)
  end
end
