class WorkoutsController < ApplicationController
  def new
    @workout = Workout.new
  end

  def index
    @workouts = Workout.all.order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    @workout = Workout.find_by(id: params[:id])
  end
  
  def create
    @workout = current_user.workouts.new(workout_params)

    if @workout.save
      redirect_to workouts_path, success: "投稿に成功しました"
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  #def update 投稿編集機能(不使用)
  #  @workout = Workout.find_by(id: params[:id])
  #  @workout.content = params[:content]
  #  @workout.save
  #  redirect_to workouts_path, success: "投稿を編集しました"
  #end

  def destroy
    @workout = Workout.find_by(id: params[:id])
    @workout.destroy
    redirect_to workouts_path, success: "投稿を削除しました"
  end

  private
  def workout_params
    params.require(:workout).permit(:image, :description)
  end
end
