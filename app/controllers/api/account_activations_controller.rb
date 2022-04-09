class Api::AccountActivationsController < ApplicationController


    def edit
        @user = User.find_by(email: params[:email])
        if (@user && !@user.activated? && @user.authenticated?(:activation, params[:id]))
            @user.activate
            flash[:success] = "Account activated!"
            token = get_token(payload(@user.username, @user.id) )
            NotifierMailer.welcome_email(@user).deliver_now
            redirect_to "https://action-game-app.herokuapp.com?token=#{token}"
        else
            if !@user
                flash[:info] = "Something went wrong!"
                redirect_to "https://action-game-app.herokuapp.com"
            elsif @user.activated?
                flash[:success] = "Your around already activated!"
                render json: {
                    message: 'hi'
                }
            else
                flash[:info] = "Something went wrong!"
                redirect_to "https://action-game-app.herokuapp.com"
            end
        end
    end
end