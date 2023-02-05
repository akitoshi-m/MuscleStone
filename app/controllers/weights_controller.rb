class WeightsController < ApplicationController
  before_action :correct_user, only: [:create]
  
  def new
    @weight = Weight.new
  end

  def index
    #配列形式でグラフ用のデータを作成する場合
    gon.data = [100, 200, 150]
    #@chart_data = Weight.all
    # gon.measure_date = []
    #   gon.measure_date << current_user.weights.pluck(:measure_date)
    # gon.weight = current_user.weights.pluck(:weight)
  end

  def create
    @weight = current_user.weights.new(weight_params)

    if @weight.save
      redirect_to weights_path, success: "入力できました"
    else
      flash.now[:danger] = "もう一度入力してください"
      render :new
    end
  end

  private
  def correct_user
    weight = Weight.find(params[:id])
    if current_user.id = weight.user.id
      redirect_to root_path
    end
  end

  def weight_params
    params.require(:weight).permit(:weight, :measure_date)
  end
end
