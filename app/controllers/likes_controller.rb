class LikesController < ApplicationController
  def index
    @like_workouts = current_user.like_workouts.order(created_at: :desc).page(params[:page]).per(25)
  end

  def create
    like = Like.new #Likeクラスのインスタンスlikeを作成
    like.user_id = current_user.id #現在ログインしているuser(current_user)のidを変数に代入
    like.workout_id = params[:workout_id] #params[:workout_id]を変数に代入
  
    if like.save #like.saveの条件分岐
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
