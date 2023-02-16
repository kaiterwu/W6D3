class UsersController < ApplicationController
    def index
        # render plain: "I'm in the index action!"
        if params.has_key?(:query)
            # @user = User.where(username:params[:query] )
            @user = User.where("username ILIKE ?","#{params[:query]}")
            return render json: 'NOT A USERNAME', status: :unprocessable_entity if @user.empty?
            render json: @user 
        else 
            @users = User.all
            render json: @users 
        end
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

    # def update_favorite
    #     if params.has_key?(:user_id) && params.has_key?(:artwork_id)
    #         @favorited = Artwork.owned_artworks(params[:user_id]).find_by(id: params[:artwork_id])
    #         unless @favorited.nil? 
    #             @favorited.update(favorited: true)
    #             return render json: 'Favorited my own!'
    #         end 
    #        @favorited = ArtworkShare 
    #         .where('artwork_shares.artwork_id = ? AND artwork_shares.viewer_id = ?',
    #             "#{params[:artwork_id]}","#{params[:user_id]}")
    #         unless @favorited.empty? 
    #             @favorited.update(favorited: true)
    #             return render json: 'Favorited my viewed!'
    #         end 
    #         render json: 'Not found', status: :unprocessable_entity
    #     else 
    #         render json: 'Not valid', status: :unprocessable_entity
    #     end
    # end 

    private
    def user_params
        params.require(:user).permit(:username)
    end

    # def user_artwork_params 
    #     params.require(:user_art).permit(:artwork_id)
    # end 
end