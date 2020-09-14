class Api::MessagesController < ApplicationController
  before_action :requires_login, only: [:index, :show, :edit, :update]
  before_action :get_message, only: [:show, :edit, :update, :destroy]
  before_action :get_user, only: [:update, :destroy]



  def index
    if (params[:chatroom_id])
      @chatroom = Chatroom.find(params[:chatroom_id])
    end
    if @chatroom
      render json: @chatroom.messages
    else
      render json: { message: 'Wrong!!!' }, status: 404
    end
  end

  def new
    @message = Message.new
    render json: @message
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      render json: @message
    else
      render json: { message: 'Wrong!!!' }, status: 404
    end
  end


  def edit
    render json: @message
  end

  def update
    if authorized(@user) && @message.update(message_params)
      render json: @message
    else
      render json: { message: 'Wrong!!!' }, status: :unauthorized
    end
  end

  def destroy
    if authorized(@user)
      render json: @message.destroy
    else
      render json: { message: 'WRONG!!!' }, status: :unauthorized
    end
  end


private

  def message_params
    params.require(:message).permit(:chatroom_id, :user_id, :message)
  end

  def get_message
    @message = Message.find(params[:id])
  end

  def get_user
    @user = User.find(@message.user_id)
  end


end
