class StationsController < ApplicationController
  before_action :find_station, only: [:show]
  skip_before_action :authenticate_user!, only: [:home, :index, :show]
  before_action :no_user_auth_needed, only: [:home, :index, :show]

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
    #@stations = Station.where.not(latitude: nil, longitude: nil)

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
    @station_reviews = @station.reviews

    # compute averages
    unless @station.reviews.empty?
      @overall_avg = compute_overall_avg.round
      @accessability_avg = compute_accessibility.round
      @condition_avg = compute_condition.round
    else
      @overall_avg = 0
      @accessability_avg = 0
      @condition_avg = 0
    end
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
  end

  def update
  end

  def destroy
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

  # Methods for review computations
  def compute_overall_avg
    overall = []
    @station_reviews.each do |review|
      overall << review.overall
    end
    overall_sum = overall.reduce(0) { |sum, num| sum + num }
    overall_sum.to_f / overall.count
  end

  def compute_accessibility
    accessibility = []
    @station_reviews.each do |review|
      accessibility << review.accessability
    end
    accessibility_sum = accessibility.reduce(0) { |sum, num| sum + num }
    accessibility_sum.to_f / accessibility.count
  end

  def compute_condition
    condition = []
    @station_reviews.each do |review|
      condition << review.condition
    end
    condition_sum = condition.reduce(0) { |sum, num| sum + num }
    condition_sum.to_f / condition.count
  end
end
