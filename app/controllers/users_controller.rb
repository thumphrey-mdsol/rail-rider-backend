class UsersController < ApplicationController
    # skip_before_action :verify_authenticity_token
    
    def show
        user = User.find(params[:id])
        render json: user
    end

    def index
        users = User.all
        render json: users, include: [:stops]
    end

    def create
        user = User.create(user_params)

        render json: user
    end

    def update
        user = User.find(params[:id])
        User.update(user_params)
        render json: user
    end

    def destroy
        user = User.find(params[:id])
        unless User.nil?
            User.destroy
            render json: user
          else
            render json: { error: "User not Found!" }, status: 404
          end
    end


    private
    def user_params
        params.require(:user).permit(:email, :password, :username)
    end
end
