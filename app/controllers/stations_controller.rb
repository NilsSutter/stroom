class StationsController < ApplicationController
  before_action :find_station, only: [:show]

  def home
    @stations = policy_scope(Station)
  end

  def index
    if params[:search].present?
      @search = params[:search]
      @address = @search["address"]
      @charger = @search["charger"]
      # @start = "#{@search["start(1i)"]}-0#{@search["start(2i)"]}-#{@search["start(3i)"]} #{@search["start(4i)"]}:#{@search["start(5i)"]}:00"
      sql_query = " \ stations.address @@ :address \ AND stations.charger @@ :charger"
      @stations = Station.joins(:bookings).where(sql_query, address: @address, charger: @charger)
    else
      @stations = Station.all
    end

    def show
    end

    private

    def find_station
      @station = Station.find(params[:id])
      authorize @station
    end
  end
end
