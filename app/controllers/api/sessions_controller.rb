class Api::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params['username'])
    if @user && @user.authenticate(params[:password])
      # payload = { username: params['username'], id: @user.id }
      if @user.activated?
        session['user_id'] = @user.id
        # return get_token(payload(@user.username, @user.id) )
        render json: {
          avatar: @user.avatar,
          token: get_token(payload(@user.username, @user.id) ),
          user: @user
        }
      else
        render json: {
          message: "Your account has not been activated yet, please check your email to activate your account."
        }
      end
    else
      render json: {
        errors: "Wrong Credentials!"
      }, status: :unauthorized
    end
  end

  def recover
    @user = User.find_by(email: params['email'].downcase)
    NotifierMailer.reset_email(@user).deliver_now if @user
  end

  def destroy
    session.delete(:user_id)
  end

end
