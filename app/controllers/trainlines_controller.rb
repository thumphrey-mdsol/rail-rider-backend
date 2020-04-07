class TrainlinesController < ApplicationController
    def show
        trainline = Trainline.find(params[:id])
        render json: trainline
    end

    def index
        trainlines = Trainline.all
        render json: trainlines
    end
end
