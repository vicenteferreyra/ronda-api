module V1
  class VenuesController < ApplicationController
    def index
      @venues = Venue.includes(:tags).all
      render :index, formats: [ :json ]
    end

    def show
      @venue = Venue.includes(:tags, :opening_hours).find(params[:id])
      render :show, formats: [ :json ]
    end
  end
end
