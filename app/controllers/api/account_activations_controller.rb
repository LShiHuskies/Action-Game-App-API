class Api::AccountActivationsController < ApplicationController


    def edit
        @user = User.find_by(email: params[:email])
        if (@user && !@user.activated? && @user.authenticated?(:activation, params[:id]))
            @user.activate
            flash[:success] = "Account activated!"
            token = get_token(payload(@user.username, @user.id) )
            NotifierMailer.welcome_email(@user).deliver_now
            redirect_to "http://localhost:3001?token=#{token}"
        else
            if !@user
                flash[:info] = "Something went wrong!"
                redirect_to "http://localhost:3001"
            elsif @user.activated?
                flash[:success] = "Your around already activated!"
            else
                flash[:info] = "Something went wrong!"
                redirect_to "http://localhost:3001"
            end
        end
    end
end