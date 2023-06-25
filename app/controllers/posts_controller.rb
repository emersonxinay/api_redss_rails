class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  def index
    message = "Bienvenido a los Posts de mi API"
    posts = Post.all

    render json: { message: message, posts: posts }
  end

  def show
    render json: @post
  end

  def create
    post = Post.new(post_params)

    if post.save
      render json: { message: 'El post se ha creado correctamente', post: post }, status: :created
    else
      render json: { error: 'No se pudo crear el post', errors: post.errors }, status: :unprocessable_entity
    end
  end

  def update
    # @post = Post.find_by(id: params[:id])
    # if @post.nil?
    #   render json: { error: "El post con el ID #{params[:id]} no existe." }, status: :not_found
    # elsif @post.user_id != params[:user_id].to_i
    #   render json: { error: "No se pudo actualizar el post con el ID #{params[:id]} porque no existe el ID del usuario #{params[:user_id]}" }, status: :unprocessable_entity
    # elsif @post.update(post_params)
    #   render json: { message: 'El post se ha actualizado correctamente', post: @post }
    # else
    #   render json: { error: "No se pudo actualizar el post con el ID #{params[:id]} porque tiene que ser el mismo usuario que lo creo" }, status: :unprocessable_entity
    # end
    @post = current_user.posts.find_by(id: params[:id])
    if @post.nil?
      render json: { error: "El post con el ID #{params[:id]} no existe o no tienes permiso para editarlo." }, status: :not_found
    elsif @post.update(post_params)
      render json: { message: 'El post se ha actualizado correctamente', post: @post }
    else
      render json: { error: "No se pudo actualizar el post con el ID #{params[:id]}" }, status: :unprocessable_entity
    end


  end

  def destroy
    if @post
      @post.destroy
      render json: { message: 'El post se ha eliminado correctamente', post: @post }, status: :ok
    else
      render json: { error: 'El post no existe' }, status: :not_found
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :user_id)
  end
end

