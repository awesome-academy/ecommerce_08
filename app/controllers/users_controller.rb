class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_user, only: :show

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "label.welcome", logo: t("logo")
      log_in @user

      redirect_to @user
    else
      render :new
    end
  end

  def show; end

  private

  def user_params
    params.require(:user).permit :name, :email, :phone, :address,
      :password, :password_confirmation
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "flash.login_plz"
    redirect_to login_path
  end

  def load_user
    @user = User.find_by id: params[:id]
    return @user if @user

    flash[:danger] = t "flash.nil_object", name: "User"
    redirect_to root_path
  end
end
