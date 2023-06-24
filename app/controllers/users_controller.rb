class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    message = "Bienvenido a los Usuarios de mi API"
    users = User.all
    
    render json: { message: message, users: users }
  end

  def show
    render json: @user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
  def reset_password_token
    user = User.find(params[:id])
    
    if user.update(user_params)
      render json: { message: 'Contraseña actualizada correctamente' }
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :encrypted_password)
  end
end
