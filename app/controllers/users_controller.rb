class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def create
        params.require(:user).permit!
        @user = User.new(name: params[:name], status: "new")
        render json: @user
    end

    def show
        render json: User.where(id: params[:id]).first
    end

    def update 
        @user = User.where(id: params[:id]).first
        if(@user.status == "new")
            @user.status = "paid"
        else 
            @user.status = "canceled"
        end
        @user.save!
    end
end
