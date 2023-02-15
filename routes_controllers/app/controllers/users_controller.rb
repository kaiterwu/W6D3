class UsersController < ApplicationController
    def index
        # render plain: "I'm in the index action!"
        @users = User.all
        render json: @users 
    end 

    def show 
        begin
            @user = User.find(params[:id])
            render json: @user
        rescue
            render json: 'invalid id', status: :unprocessable_entity
        end
    end 

    # params need to be nested within a user hash
    # key = user[name]  value = 'Alvin'
    def create
        @user = User.new(user_params)
        if @user.save
          render json: @user
        else
          render json: @user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to user_url(@user.id)
        else
            render json: @user.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        @user = User.find(params[:id])
        if @user.destroy
            render json: "user destroyed"
        else
            render json: @user.errors.full_messages, status: :unprocessable_entity
        end
    end

    private
    def user_params
        params.require(:user).permit(:username)
    end
end