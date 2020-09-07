require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  def setup
    @user = User.create(username: 'tester', first_name: 'tester', last_name: 'name', email: "something@email.com", password: '12345678')
    @game = Game.create(name: "Game for Message")
    @user_game = UserGame.create(user: @user, game: @game)
    @chatroom = Chatroom.create(user_game: @user_game)
    @message = Message.new(user: @user, chatroom: @chatroom)
  end

  test "Message needs to have a message attribute" do
    @message.save
    assert_not @message.valid?
  end

  test "Message needs to have content" do
    @message.message = ""
    @message.save
    assert_not @message.valid?
  end

  test "Message has to have message content and no more than 300 characters" do
    @message.message = "hello"
    assert @message.valid?
  end

  test "Message cannot have more than 300 characters" do
    @message.message = "how are you doing todayf? its been awhile you know, maybe we
    should play this game more often because people just dont want to play anymore
    what do you guys think? I think we should definitely play more, it makes no sense
    for us to not play, because its a lot of fun when we do and not much fun when we dont
    so lets play as much as we can and keep playing."

    assert_not @message.valid?
  end

end
