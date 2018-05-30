class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
      session[:user_id] = @user.id
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:user]
      if @user.update_attribute(:icon, params[:user][:icon])
        redirect_to user_path, notice: 'アイコンを変更しました'
      else
        render 'edit'
      end
    else
      @user.remove_icon!
      if @user.update_attribute(:icon, @user.icon)
        redirect_to user_path, notice: 'アイコンを変更しました'
      else
        render 'edit'
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :icon)
  end
end
