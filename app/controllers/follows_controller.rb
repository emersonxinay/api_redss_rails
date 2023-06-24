class FollowsController < ApplicationController
  def create
    follow = Follow.new(follow_params)
    if follow.save
      render json: { message: 'Has seguido correctamente', follow: follow }, status: :created
    else
      render json: follow.errors, status: :unprocessable_entity
    end
  end

  def destroy
    follow = Follow.find_by(follower_id: params[:follower_id], following_id: params[:following_id])
    follow.destroy
    head :no_content
  end

  private

  def follow_params
    params.require(:follow).permit(:follower_id, :following_id)
  end
end
