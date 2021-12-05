class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user &.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in @user   #'sessions_helper.rb'に書いたヘルパーメソッドを'user'を引数にして呼び出している
      params[:session][:remember_me] == '1'? remember(@user) : forget(@user)  #三項演算子（ternary operator）
      redirect_to @user  #参考→https://qiita.com/japwork/items/b84e3fbee5cc6946316c
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
