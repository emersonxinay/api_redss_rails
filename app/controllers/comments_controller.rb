class CommentsController < ApplicationController

  before_action :set_comment, only: [:show, :update, :destroy]

  def index
    comments = Comment.where(post_id: params[:post_id])
    user_section = "Sección de comentarios del usuario"

    render json: { message: user_section, comments: comments }
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
end
