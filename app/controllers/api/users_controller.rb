class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  # before_action :requires_login, only: [:index, :show, :destroy]
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
      render json: @user
    else
      render json: @user.errors.full_messages
    end

  end

  def show
    # return unless authorized(@user)

    render json: @user
  end

  def edit

  end

  def update

    # return unless authorized(@user)

    render json: @user
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
