# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  def destroy
    email = current_user.email
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    if signed_out
      respond_to do |format|
        format.json { render json: { message: 'Sesión cerrada exitosamente', email: email } }
      end
    else
      respond_to do |format|
        format.json { render json: { error: 'Error al cerrar sesión' }, status: :unprocessable_entity }
      end
    end
  end
end
