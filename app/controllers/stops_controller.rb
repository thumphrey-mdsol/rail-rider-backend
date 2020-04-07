class StopsController < ApplicationController
    def show
        stop = Stop.find(params[:id])
        render json: stop
    end

    def index
        stops = Stop.all
        render json: stops
    end
end
