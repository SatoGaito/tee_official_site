class UsersController < ApplicationController

  before_action :non_active_user, only: :index
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :authenticate_user!

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "更新を完了しました。"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :nickname, :gender, :college, :grade, :introduction, :profile_image, :active, :executive, :image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    if user_signed_in? && @user.id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to user_path(current_user)
    end
  end

  def non_active_user
    unless user_signed_in? && current_user.active?
      flash[:notice] = "アカウントがアクティブではありません"
      redirect_to '/'
    end
  end
end