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
    if User.exists?(email: user_params[:email])
      render json: { error: 'El correo electrónico ya está en uso' }, status: :unprocessable_entity
    else
      user = User.new(user_params)
      if user.save
        render json: user, status: :created
      else
        render json: user.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    @user = User.find_by(id: params[:id])

    if @user.nil?
      render json: { error: "El usuario con el ID #{params[:id]} no existe." }, status: :not_found
    elsif user_params[:email].present? && User.exists?(email: user_params[:email])
      render json: { error: 'El correo electrónico ya está en uso. Por favor, elija otro correo electrónico.' }, status: :unprocessable_entity
    elsif @user.update(user_params)
      render json: { message: 'El usuario se ha actualizado correctamente', user: @user }
    else
      render json: { error: 'No se pudo actualizar el usuario' }, status: :unprocessable_entity
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
    if @user.posts.empty?
      deleted_user = @user.as_json
      @user.destroy
      render json: { message: 'El usuario ha sido eliminado correctamente', deleted_user: deleted_user }
    else
      render json: { error: 'El usuario no puede ser eliminado porque tiene post(s) asociado(s), primero elimina esos post' }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :encrypted_password)
  end
end
