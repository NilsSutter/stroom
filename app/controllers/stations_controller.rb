class StationsController < ApplicationController
  def home
  end

  def index
    @stations = Station.all
  end
end
