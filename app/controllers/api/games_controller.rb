class Api::GamesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :requires_login, only: [:index, :show, :edit, :update, :main_room,
                                        :main_room_chatroom, :top_scores, :versus_mode_lobby,
                                        :versus_mode_main_chatroom]
  before_action :get_game, only: [:show, :edit, :update, :reject]

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
      @user2 = User.where(email: params[:game][:email].downcase, username: params[:game][:username]).first if params[:game][:email]
      if @user2 && @user
        @game.users << @user
        @game.users << @user2
        @user2.send_game_email(@user, @game)
        ActionCable.server.broadcast 'GameChannel', GameSerializer.new(@game)
        render json: @game
      else
        @game.users << @user if @user

        render json: @game
      end

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

  def top_scores
    game_type = params[:game_type] || 'single'
    top = params[:top] || 10
    @games = Game.where.not(score: nil).where(game_type: game_type).order("score DESC").limit(top)
    render json: @games
  end

  def versus_mode_lobby
    @game = Game.where(name: "versus_lobby").first
    if @game
      render json: @game.chatrooms.first.messages.where(created_at: Time.new(params[:year], params[:month], params[:day]).beginning_of_day..Time.new(params[:year], params[:month], params[:day]).end_of_day)
    else
      render json: { message: "Off Limits!" }, status: 404
    end
  end

  def versus_mode_main_chatroom
    @game = Game.where(name: "versus_lobby").first
    if @game
      render json: @game.chatrooms.first
    else
      render json: { message: "Off Limits!" }, status: 404
    end
  end

  def available_versus_games
    @games = Game.where(game_type: 'versus').where(score: nil)

    render json: @games
  end

  def reject
    @user = @game.users.find(params[:game][:user_id])

    if @user
      return if @game.rejected == true

      @game.update(rejected: true)
      ActionCable.server.broadcast 'GameChannel', GameSerializer.new(@game)
      render json: @game
    else
      render json: { message: "Off Limits!" }, status: 404
    end
  end

  private

  def game_params
    params.require(:game).permit(:name, :score, :difficulty, :weapon, :backup_supply, :game_type, :accuracy)
  end

  def get_game
    @game = Game.find(params[:id])
  end

end
