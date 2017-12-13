class UsersController < ApplicationController
  before_action :set_user

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to root_path
  end

  def show
    @item = Item.new
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :surname, :age)
  end

end
