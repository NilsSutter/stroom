class StationsController < ApplicationController
  before_action :find_station, only: [:show]
  before_action :no_user_auth_needed, only: [:home, :index, :show]
  skip_before_action :authenticate_user!, only: [:home, :index, :show, :delete_photo]

  def home
    @disable_nav = true
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
      sql_query = " \ stations.address @@ :address \ AND stations.charger @@ :charger"
      @stations = Station.where(sql_query, address: @address, charger: @charger)
    end

    # Mapbox Stuff
    @stations = Station.where.not(latitude: nil, longitude: nil)

    @markers = @stations.map do |station|
      {
        lat: station.latitude,
        lng: station.longitude
        #image_url: helpers.asset_url('REPLACE_THIS_WITH_YOUR_IMAGE_IN_ASSETS')
      }
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
