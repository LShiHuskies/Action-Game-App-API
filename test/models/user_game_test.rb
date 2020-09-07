require 'test_helper'

class UserGameTest < ActiveSupport::TestCase

  def setup
    @user = User.create(username: 'tester', first_name: 'tester', last_name: 'name', email: "something@email.com", password: '12345678')
    @game = Game.create(name: "Game for Message")
    @user_game = UserGame.new
  end

  test 'user game needs a user and needs a game to be valid' do
    assert_not @user_game.valid?
  end

  test 'user game is valid with a user and game' do
    @user_game.user = @user
    @user_game.game = @game

    assert @user_game.valid?
  end


end
