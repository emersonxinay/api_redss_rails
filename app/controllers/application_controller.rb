class ApplicationController < ActionController::API
  
  def route_not_found
    render json: { error: 'La ruta solicitada no existe' }, status: :not_found
  end

  private

  def authenticate_user!
    if user_signed_in?
      # El usuario ha iniciado sesión, continuar con la acción
    else
      render json: { error: 'Necesitas iniciar sesión' }, status: :unauthorized
    end
  end

  
end
