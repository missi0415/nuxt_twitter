class Api::V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: users.as_json(only: %i[id name introduction])
  end

  def create
    puts params
    @user = User.new(user_params)
    @user.is_active = true
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :uid,
      :introduction,
      :is_active,
      :admin
    )
  end
end
