class FavoritesController < ApplicationController
    def show
        favorite = Favorite.find(params[:id])
        render json: favorite
    end

    def index
        favorites = Favorite.all
        render json: favorites, include: [:stops, :users]
    end
end
