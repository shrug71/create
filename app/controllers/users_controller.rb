class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def create
    role_name = params[:user][:role]
    role = Role.find_by(name: role_name)

    @user = User.new(user_params)
    @user.role = role

    if @user.save
      render json: { message: 'User was successfully created.', user: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

   def destroy
    if @user.destroy
      render json: { message: 'User was successfully deleted.' }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def new
    @user = User.new
  end

  def show
    render json: @user, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
