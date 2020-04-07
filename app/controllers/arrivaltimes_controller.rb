class ArrivaltimesController < ApplicationController
    def show
        arrivaltime = Arrivaltime.find(params[:id])
        render json: arrivaltime
    end

    def index
        arrivaltimes = Arrivaltime.all
        render json: arrivaltimes
    end
end
