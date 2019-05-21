class StationsController < ApplicationController
  before_action :find_station, only: [:show]
  before_action :no_user_login_needed, only: [:home, :index, :show]

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
  end

  private

  def no_user_login_needed
    @stations = policy_scope(Station)
  end

  def find_station
    @station = Station.find(params[:id])
    authorize @station
  end
end
