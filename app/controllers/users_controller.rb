class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :following, :followers]
  before_action :logged_in?, only: [:index, :edit, :update, :destroy]
  before_action :admin_user, only: :destroy

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
      session[:user_id] = @user.id
      redirect_to user_path(@user), success: '登録ができました'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    #attributes 対象となるカラムだけを更新する ※バリデーションが走る
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
  
  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end