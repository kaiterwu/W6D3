class ArtworkSharesController < ApplicationController
   
    # params need to be nested within a artwork_share hash
    # key = artwork_share[name]  value = 'Alvin'
    def create
        # debugger
        @artwork_share = ArtworkShare.new(artwork_share_params)
        if @artwork_share.save
          render json: @artwork_share
        else
          render json: @artwork_share.errors.full_messages, status: :unprocessable_entity
        end
    end
  
   
  
    def destroy
        @artwork_share = ArtworkShare.find(params[:id])
        if @artwork_share.destroy
            render json: "artwork_share destroyed"
        else
            render json: @artwork_share.errors.full_messages, status: :unprocessable_entity
        end
    end
  
    private
    def artwork_share_params
        # debugger
        params.require(:artwork_share).permit(:viewer_id, :artwork_id)
    end
  end