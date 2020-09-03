class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :requires_login, only: [:index, :show, :update, :destroy]
  before_action :get_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: {
        user: @user,
        token: get_token(payload(@user.username, @user.id) )
      }
    else
      render json: @user.errors.full_messages
    end

  end

  def show

    if !authorized(@user)
      render json: { message: 'Off limits!' }
      return
    end

    render json: @user
  end

  def edit

  end

  def update

    return unless authorized(@user)

    if @user.update(user_params)
      render json: @user
    else
      render json: {message: 'WRONG!!!'}
    end
  end


  def destroy
    @user.destroy
  end



  private

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :password, :email, :avatar)
  end

  def get_user
    @user = User.find(params[:id])
  end


end
