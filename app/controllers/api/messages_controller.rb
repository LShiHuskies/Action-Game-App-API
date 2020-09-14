class Api::MessagesController < ApplicationController
  before_action :requires_login, only: [:index, :show, :edit, :update]
  before_action :get_message, only: [:show, :edit, :update]
  # before_action :get_chatroom, only: [:index, :show, :edit, :update, :destroy]
  # before_action :get_user
  # before_action :get_user_game




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
    byebug
  end


private

  def message_params
    # params[:message][:user] = JSON.parse(params[:message][:user])
    # params[:message][:chatroom] = JSON.parse(params[:message][:chatroom])
    byebug
    params.require(:message).permit(:chatroom_id, :user_id, :message)
  end

  def get_message
    Message.find(params[:id])
  end


end
