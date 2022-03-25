class Api::GamesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :requires_login, only: [:index, :show, :edit, :update, :main_room]
  before_action :get_game, only: [:show, :edit, :update]

  def index
    @games = Game.all
    render json: @games
  end

  def new
    @game = Game.new()
    render json: @game
  end

  def show
    render json: @game
  end

  def create
    @game = Game.new(game_params)
    @user = User.find(params[:game][:user_id]) if params[:game][:user_id]
    if (@game.save)
      if @user
        @game.users << @user
      end
      render json: @game
    else
      render json: {message: 'Wrong!!!'}, status: 404
    end
  end

  def edit
    render json: @game
  end

  def update
    if @game.update(game_params)
      render json: @game
    else
      render json: { message: 'Off limits!' }, status: :unauthorized
    end
  end

  def main_room
    @game = Game.where(name: "main_room").first
    if @game
      render json: @game.chatrooms.first.messages.where(created_at: Time.new(params[:year], params[:month], params[:day]).beginning_of_day..Time.new(params[:year], params[:month], params[:day]).end_of_day)
    else
      render json: { message: "Off Limits!" }, status: 404
    end
  end

  def main_room_chatroom
    @game = Game.where(name: "main_room").first
    if @game
      render json: @game.chatrooms.first
    else
      render json: { message: "Off Limits!" }, status: 404
    end
  end


  private

  def game_params
    params.require(:game).permit(:name, :score, :type, :difficulty, :weapon, :backup_supply)
  end

  def get_game
    @game = Game.find(params[:id])
  end

end
