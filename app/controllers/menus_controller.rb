class MenusController < ApplicationController
  def new
    @menu = Menu.new
    @user = User.find(params[:user_id])
  end
  
  def index
    # @menus = Menu.all.order(created_at: :desc)
    @user = User.find(params[:user_id])
  end
  
  def create
    @menu = current_user.menus.new(menu_params)

    if @menu.save
      redirect_to menus_path(user_id: current_user.id), success: "トレーニングメニューを作成しました"
    else
      flash.now[:danger] = "メニュー作成に失敗しました"
      render :new
    end
  end

  def destroy
    @menu = Menu.find_by(id: params[:id])
    @menu.destroy
    redirect_to menus_path(user_id: current_user.id), success: "メニューを削除しました。"
  end
  
  private
  def menu_params
    params.require(:menu).permit(:part, :training_name, :weight, :rep, :set, :comment)
  end

end
