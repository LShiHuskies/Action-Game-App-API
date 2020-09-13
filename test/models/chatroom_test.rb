require 'test_helper'

class ChatroomTest < ActiveSupport::TestCase

  def setup
    @user = User.create(username: 'tester', first_name: 'tester', last_name: 'name', email: "something@email.com", password: '12345678')
    @game = Game.create(name: "Game for Message")
    @user_game = UserGame.create(user: @user, game: @game)
    @chatroom = Chatroom.new
  end

  test 'Chatroom needs a user game' do
    assert_not @chatroom.valid?
  end

  test 'Chatroom is valid as long as it has a userGame' do
    @chatroom.user_game = @user_game
    assert @chatroom.valid?
  end

end
