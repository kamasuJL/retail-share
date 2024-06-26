class Public::UsersController < ApplicationController
  # before_action :authenticate_user!, except: [:top]
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :is_matching_login_user, only: [:unsubscribe, :withdraw]
  before_action :ensure_guest_user, only: [:edit]
  
  def mypage
    @posts = current_user.posts
    @user = current_user
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  
  def index
    @users = User.all
  end
  
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user)
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
    params.require(:user).permit(:name, :email, :is_active, :profile_image)
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path, alert: "Access denied."
    end
  end
  
  def is_matching_login_user
    user = User.find_by(id: params[:user_id])
    unless user && user.id == current_user.id
      redirect_to root_path, alert: "Access denied."
    end
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , alert: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  
  
end
