class Api::UserGamesController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :requires_login, only: [:show, :play]
    before_action :get_user_game, only: [:show, :play, :move, :fire_bullet]

    def show
      render json: @user_game
    end

    def play
      if @user_game.update(accepted: true)
        if (@user_game.health != 0 && !@user_game.health) || !@user_game.top || @user_game.left || !@user_game.direction
          @game = Game.find(@user_game.game_id)
          @other_user_game = @game.user_games.select do |user_game| user_game.id != @user_game.id end.first
          
          if !@user_game.direction
            @user_game.update(health: 100, top: 40, left: 10, direction: 'RIGHT')
            @other_user_game.update(health: 100, top: 40, left: 70, direction: 'LEFT')
          end
        end
        ActionCable.server.broadcast "UserGamesChannel", UserGameSerializer.new(@user_game)
        render json: @user_game
      else
        render json: { message: "Off Limits!" }, status: 404
      end
    end

    def move
      @user_game.update(user_game_params)
      
      ActionCable.server.broadcast "UserGamesChannel", UserGameSerializer.new(@user_game)
      render json: {
        success: 'hello'
      }
    end

    def fire_bullet
      ActionCable.server.broadcast "UserGamesChannel", {
        id: @user_game.id,
        fireBullets: params[:fireBullets]
      }
      render json: {
        success: 'hello'
      }
    end

    private

    def user_game_params
        params.require(:user_game).permit(:direction, :health, :top, :left)
      end

    def get_user_game
      @user_game = UserGame.find(params[:id])
    end
end