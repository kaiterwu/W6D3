class ArtworksController < ApplicationController
  def index
      # render plain: "I'm in the index action!"
      if params.has_key?(:user_id)
        owned_artworks = Artwork
        .joins(:artist)
        .where("artworks.artist_id = #{params[:user_id]}")

        shared_artworks = Artwork 
        .joins(:artwork_shares)
        .where("artwork_shares.viewer_id = #{params[:user_id]}")
        @all_artworks_for_user_id = owned_artworks + shared_artworks 
       render json: @all_artworks_for_user_id
      else
        render json: 'invalid id', status: :unprocessable_entity
        end

#     @shared_artworks = Artwork 
#     .left_joins(:artworks_for_user_id)
#     .where("artworks.artist_id = #{params[:user_id]}")
#    render json: @shared_artworks 
#   else
#     render json: 'invalid id', status: :unprocessable_entity
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

  private
  def artwork_params
      params.require(:artwork).permit(:title, :image_url, :artist_id)
  end
end