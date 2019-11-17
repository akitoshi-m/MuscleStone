class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :following, :followers]

  def new
    @user = User.new
  end

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @workouts = @user.workouts.page(params[:page]).per(10)
  end
    
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, success: '登録ができました'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    #attributes 対象となるカラムだけを更新する　※バリデーションが走る
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'ユーザー編集が完了しました'
      redirect_to user_path(@user)
    else
      flash.now[:danger] = 'ユーザー編集に失敗しました'
      render 'edit'
    end
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(10)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(10)
    render 'show_follow'
  end  
  
  private
  def correct_user
    user = User.find(params[:id])
    if current_user != user
      redirect_to root_path
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_icon, :height, :weight, :comment)
  end
  
  # def user_update_params
  #   params.require(:user).permit(:name, :email, :height, :weight, :comment)
  # end
end