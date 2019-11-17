class CommentsController < ApplicationController
  def new
    #workout_idを受け取る。これを次のフォームに渡す
    @comment = Comment.new
    @workout_id = params[:workout_id]
  end
  
  def create #コメント登録
    @comment = Comment.new
    # 記事番号をパラメータから受け取る
    # コメントの内容をパラメータから受け取る
    @comment.user_id = current_user.id
    @comment.workout_id = params[:comment][:workout_id] #ビューに記事番号を伝えている
    @comment.content = params[:comment][:content]

    # binding.pry   
    if @comment.save #コメント登録の条件分岐
      redirect_to workouts_path, success: 'コメントに成功しました' 
    else
      flash.now[:danger] = "コメントに失敗しました"
      render :new
    end
  end
end
