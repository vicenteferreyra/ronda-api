module V1
  class VenuesController < ApplicationController
    def index
      @venues = Venue.includes(:tags).all
      render :index, formats: [ :json ]
    end
  end
end
