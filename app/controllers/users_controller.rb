class UsersController < ApplicationController
  def signup
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    puts "~~~~~~~ [S]"
    # puts user.first
    puts "~~~~~~~ [E]"
    if @user.save
      puts "~~~~~~~ [user.save ture]"
      cookies[:auth_token] = @user.auth_token
      redirect_to :root
    else
      puts "~~~~~~~ [user.save false]"
      render :signup
    end
  end
  
  def create_login_session
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      # session[:user_id] = user.id
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      flash.notice = "登录成功"
      redirect_to :root
    else
      flash.notice = "登录失败"
      redirect_to :login
    end
  end
  
  def logout
    # session[:user_id] = nil
    cookies.delete(:auth_token)
    redirect_to :root
  end
  
  private
  def user_params
      # [Keith] This can not work.
      # params.require(:user).permit
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
