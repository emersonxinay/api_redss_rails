# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  # before_action :authenticate_user!  # Comentar o eliminar esta línea

  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      render json: { message: 'Registro exitoso', email: resource.email }
    else
      render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
