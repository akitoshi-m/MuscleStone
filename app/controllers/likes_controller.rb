class LikesController < ApplicationController
  def index
    @like_workouts = current_user.like_workouts.order(created_at: :desc).page(params[:page]).per(25)
  end

  def create
    like = Like.new
    like.user_id = current_user.id
    like.workout_id = params[:workout_id]
  
    if like.save
      redirect_to workouts_path, success: 'いいねしました'
    else
      redirect_to workouts_path, danger: 'いいねに失敗しました'
    end
  end
  
  def destroy
    @like = Like.find_by(user_id: current_user.id, workout_id: params[:workout_id])
    @like.destroy
    redirect_to workouts_path, success: 'いいねを取り消しました'
  end
end
