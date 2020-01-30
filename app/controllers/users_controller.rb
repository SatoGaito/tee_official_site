class UsersController < ApplicationController

  before_action :non_active_user, only: :index
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user)
  end

  private
  def user_params
    params.require(:user).permit(:name, :nickname, :gender, :college, :grade, :introduction, :profile_image, :active, :executive)
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
      flash[:notice] = "アカウントがactiveではありません"
      redirect_to '/'
    end
  end
end