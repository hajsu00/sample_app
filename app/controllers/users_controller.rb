class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      #保存が成功した場合
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_url(@user)
    else
      render 'new'  #'app/views/users/new.html.erb'のこと
    end
  end
  
  def edit
    @user = User.find_by(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      #成功した場合の処理
    else
      render 'edit' #'app/views/users/edit.html.erb'のこと
    end
  end
  private
  
    def user_params #https://railstutorial.jp/chapters/sign-up?version=4.0
      params.require(:user).permit(:name, :email, :password,:password_confirmation)
    end
end
