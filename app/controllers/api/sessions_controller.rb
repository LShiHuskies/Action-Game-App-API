class Api::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(username: params['username'])

    if @user && @user.authenticate(params[:password])
      # payload = { username: params['username'], id: @user.id }
      session['user_id'] = @user.id
      render json: {
        avatar: @user.avatar,
        token: get_token(payload(@user.username, @user.id) )
      }
    else
      render json: {
        errors: "Wrong Credentials!"
      }, status: :unauthorized
    end
  end

  def destroy
    session.delete(:user_id)
  end

end
