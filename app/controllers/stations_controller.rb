class StationsController < ApplicationController
  before_action :find_station, only: [:show, :destroy]
  skip_before_action :authenticate_user!, only: [:home, :index, :show]
  before_action :no_user_auth_needed, only: [:home, :index, :show]

  def home
    @disable_nav = true
  end

  def index
    if params[:search].present?
      @search = params[:search]
      @charger = @search["charger"]
      @address = @search["address"]
      @radius = @search["radius"].to_i


      if (@address.empty? || @address.nil?) && (@charger.nil? || @charger.empty?)
        @stations = Station.all

      elsif @address.nil? || @address.empty?
        sql_query = " \ stations.charger @@ :charger"
        @stations = Station.where(sql_query, charger: @charger)

      elsif @charger.nil? || @charger.empty?
        # sql_query = " \ stations.address @@ :address"
        # @stations = Station.where(sql_query, address: @address)
        @stations = Station.near(@address, @radius)

      else
        sql_query = " \ stations.charger @@ :charger"
        @stations = Station.near(@address, @radius).where(sql_query, charger: @charger)
      end
    else
      @stations = Station.all
    end

    # Mapbox Stuff
    @stations_for_markers = Station.where.not(latitude: nil, longitude: nil)

    @markers = @stations_for_markers.map do |station|
      {
        lat: station.latitude,
        lng: station.longitude,
        infoWindow: render_to_string(partial: "partials/infowindow", locals: { station: station })
      }
    end
  end

  def show
    # TO DO: Refactor reviews into review controller
    @new_booking = Booking.new
    @review = Review.new
    @booking = @station.bookings.last
    @station_reviews = @station.reviews
    @reviews = Review.where(station: @station)
    # compute averages PUT IN MODEL?
    unless @station.reviews.empty?
      @overall_avg = @station.compute_overall_avg.round
      @accessability_avg = @station.compute_accessibility.round
      @condition_avg = @station.compute_condition.round
    else
      @overall_avg = 0
      @accessability_avg = 0
      @condition_avg = 0
    end
    @marker =
      [{
        lat: @station.latitude,
        lng: @station.longitude
      }]
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
      current_user.owner = true
      redirect_to station_path(@station)
    else
      render :new
    end
  end

  def edit
    @station = Station.find(params[:id])
    authorize @station
  end

  def update
    @station = Station.find(params[:id])
    authorize @station

    if @station.update_attributes(params_station)
      flash[:success] = "Station updated"
      redirect_to bookings_path
    else
      render 'edit'
    end

  end

  def destroy
    @station.destroy
    redirect_to bookings_path
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
    params.require(:station).permit(:address, :charger, :photo, :instruction, :price)
  end
end
