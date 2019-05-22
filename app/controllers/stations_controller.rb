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
    @station_reviews = @station.reviews
    # compute averages
    @overall_avg = compute_overall_avg.round
    @accessability_avg = compute_accessibility.round
    @condition_avg = compute_condition.round
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
