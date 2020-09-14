class Api::GamesController < ApplicationController
  before_action :requires_login, only: [:index, :show, :edit, :update]
  before_action :get_game, only: [:show, :edit, :update]

  def index
    @games = Game.all
    render json: @games
  end

  def new
    @game = Game.new()
    render json: @game
  end

  def create
    @game = Game.new(game_params)
    if (@game.save)
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


  private

  def game_params
    params.require(:game).permit(:name, :score, :type)
  end

  def get_game
    @game = Game.find(params[:id])
  end

end
