class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    #配列形式でグラフ用のデータを作成
    @chart_data = [['2019-06-01', 100], ['2019-06-02', 200], ['2019-06-03', 150]]
  end
    
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to workouts_path, success: '登録ができました'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'ユーザー編集が完了しました'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_name)
  end
end
