class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @workout_id = params[:workout_id]
  end
  
  def create
    @comment = Comment.new
    @comment.user_id = current_user.id
    @comment.workout_id = params[:comment][:workout_id]
    @comment.content = params[:comment][:content]

    if @comment.save
      redirect_to workouts_path, success: 'コメントに成功しました' 
    else
      flash.now[:danger] = "コメントに失敗しました"
      render :new
    end
  end
end
