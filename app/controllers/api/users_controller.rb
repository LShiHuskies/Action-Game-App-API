class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :requires_login, only: [:index, :show, :edit, :update, :destroy]
  before_action :get_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def new
    @user = User.new
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # token = get_token(payload(@user.username, @user.id))
      # byebug
      @user.send_activation_email

      render json: {
        message: "Please check your email to activate your account."
      }
      
      # NotifierMailer.welcome_email(@user).deliver_now
      # render json: {
      #   user: @user,
      #   token: get_token(payload(@user.username, @user.id) )
      # }
    else
      render json: @user.errors.full_messages
    end

  end

  def show
    if !authorized(@user)
      render json: { message: 'Off limits!' }, status: :unauthorized
    else
      render json: @user
    end
  end

  def edit
    render json: @user
  end

  def update
    if @user.update(user_params) && authorized(@user)
      NotifierMailer.update_account_notify(@user).deliver_now
      render json: @user
    else
      render json: {message: 'WRONG!!!'}, status: :unauthorized
    end
  end


  def destroy
    if authorized(@user)
      render json: @user.destroy
    else
      render json: { message: 'WRONG!!!' }, status: :unauthorized
    end

  end


  private

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :password, :email, :avatar)
  end

  def get_user
    @user = User.find(params[:id])
  end


end
