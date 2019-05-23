class ReviewsController < ApplicationController
  def create
    # create new review instance with with whitelisting approach
    @review = Review.new(review_params)
    authorize @review
    # find the booking instance that belongs to the station
    @booking = Booking.find(params[:booking_id])
    @station = @booking.station
    # tell review instance to which booking instance it belongs to
    @review.booking = @booking

    # check if the review was created
    if @review.save!
      # if yes, redirect to detail-page
      redirect_to station_path(@station)
      # if not, render the show page
    else
      render './stations/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:accessability, :condition, :overall, :content)
  end
end
