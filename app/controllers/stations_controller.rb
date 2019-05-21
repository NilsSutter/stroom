class StationsController < ApplicationController
  def index
  end

  def show
    @station = Station.find(params[:id])
    @review = Review.new
    @booking = @station.bookings.last
  end
end
