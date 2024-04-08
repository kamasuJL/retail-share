class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def mypage
    @posts = current_user.posts
    @user = current_user
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path(@user)
    else
      render "edit"
    end
  end
  
  def unsubscribe
  end
  
  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    redirect_to new_user_registration_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :is_active)
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to mypage_path(current_user)
    end
  end
  
end