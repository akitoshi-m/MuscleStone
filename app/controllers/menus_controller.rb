class MenusController < ApplicationController
  def new
    @menu = Menu.new
  end
  
  def index
    @menus = Menu.all.order(created_at: :desc)
    @user = User.find_by(params[:id])
  end
  
  def create
    @menu = current_user.menus.new(menu_params)

    if @menu.save
      redirect_to menus_path, success: "トレーニングメニューを作成しました"
    else
      flash.now[:danger] = "メニュー作成に失敗しました"
      render :new
    end
  end

  def destroy
    @menu = Menu.find_by(id: params[:id])
    @menu.destroy
    redirect_to menu_path, success: "メニューを削除しました。"
  end
  
  private
  def menu_params
    params.require(:menu).permit(:part, :training, :weight, :rep, :set, :comment)
  end

end
