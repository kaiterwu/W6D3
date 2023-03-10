class ArtworksController < ApplicationController
  def index
      # render plain: "I'm in the index action!"
        if params.has_key?(:user_id)
        
            @all_artworks_for_user_id = Artwork.artworks_for_user_id(params[:user_id])
            render json: @all_artworks_for_user_id
        else
            render json: 'invalid id', status: :unprocessable_entity
        end
  end 

  def show 
      begin
          @artwork = Artwork.find(params[:id])
          render json: @artwork
      rescue
          render json: 'invalid id', status: :unprocessable_entity
      end
  end 

  # params need to be nested within a artwork hash
  # key = artwork[name]  value = 'Alvin'
  def create
      @artwork = Artwork.new(artwork_params)
      if @artwork.save
        render json: @artwork
      else
        render json: @artwork.errors.full_messages, status: :unprocessable_entity
      end
  end

  def update
      @artwork = Artwork.find(params[:id])
      if @artwork.update(artwork_params)
          redirect_to artwork_url(@artwork.id)
      else
          render json: @artwork.errors.full_messages, status: :unprocessable_entity
      end
  end

  def destroy
      @artwork = Artwork.find(params[:id])
      if @artwork.destroy
          render json: "artwork destroyed"
      else
          render json: @artwork.errors.full_messages, status: :unprocessable_entity
      end
  end

  def update_favorite
    if params.has_key?(:user_id) && params.has_key?(:artwork_id)
        @favorited = Artwork.find_by(id: params[:artwork_id], artist_id: params[:user_id]) ||
                    ArtworkShare.find_by(artwork_id: params[:artwork_id], viewer_id: params[:user_id]) 
                    
        unless @favorited.nil? 
            @favorited.update(favorited: true)
            render json: (@favorited.is_a?(Artwork) ? 'Favorited my own!' : 'Favorited my viewed!')
            return
        end

        render json: 'Not found', status: :unprocessable_entity
    else 
        render json: 'Not valid', status: :unprocessable_entity
    end
end 

  private
  def artwork_params
      params.require(:artwork).permit(:title, :image_url, :artist_id)
  end
end