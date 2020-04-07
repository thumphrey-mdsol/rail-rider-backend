class ArrivalsController < ApplicationController
    def show
        arrival = Arrival.find(params[:id])
        render json: arrival
    end

    def index
        arrivals = Arrival.all
        render json: arrivals
    end
end
