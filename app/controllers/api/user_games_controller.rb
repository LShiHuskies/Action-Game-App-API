class Api::UserGamesController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :requires_login, only: [:show, :play]
    before_action :get_user_game, only: [:show, :play]

    def show
      render json: @user_game
    end

    def play
      if @user_game.update(accepted: true)
        ActionCable.server.broadcast "UserGamesChannel", UserGameSerializer.new(@user_game)
        render json: @user_game
      else
        render json: { message: "Off Limits!" }, status: 404
      end
    end

    private

    def get_user_game
      @user_game = UserGame.find(params[:id])
    end
end