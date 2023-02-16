class CommentsController < ApplicationController
   
  # params need to be nested within a comment hash
  # key = comment[name]  value = 'Alvin'
  def index
    if params.has_key?(:user_id)
      @comment = Comment.where(author_id: params[:user_id])
      render json: @comment
    elsif params.has_key?(:artwork_id)
      @comment = Comment.where(artwork_id: params[:artwork_id])
      render json: @comment
    else
      render json: 'invalid id', status: :unprocessable_entity
    end
  end


  def create
      # debugger
      @comment = Comment.new(comment_params)
      if @comment.save
        render json: @comment
      else
        render json: @comment.errors.full_messages, status: :unprocessable_entity
      end
  end

 

  def destroy
      @comment = Comment.find(params[:id])
      if @comment.destroy
          render json: "comment destroyed"
      else
          render json: @comment.errors.full_messages, status: :unprocessable_entity
      end
  end

  private
  def comment_params
      # debugger
      params.require(:comment).permit(:author_id, :body, :artwork_id)
  end
end