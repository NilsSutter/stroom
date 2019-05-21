class StationsController < ApplicationController
  before_action :find_station, only: [:show]

  def home
    @stations = policy_scope(Station)
  end

  def show
  end

  private

  def find_station
    @station = Station.find(params[:id])
    authorize @station
  end
end
