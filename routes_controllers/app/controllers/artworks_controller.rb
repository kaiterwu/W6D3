class ArtworksController < ApplicationController
  def index
      # render plain: "I'm in the index action!"
      @artworks = Artwork.all
      render json: @artworks 
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