require 'test_helper'
require 'json'


class MessagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: 'testing1', first_name: 'tester', last_name: 'tester', password: '12345678', email: 'test@example.com')
    @game = Game.create(name: 'New Game')
    @user_game = UserGame.create(user: @user, game: @game)
    @chatroom = Chatroom.create(user_game: @user_game)
    @message = Message.new(user: @user, chatroom: @chatroom, message: 'how are you?')
  end


  test 'needs to be logged in in order to see messages' do
    get api_messages_path

    assert_response 401
  end

  test 'should be able to create messages' do
    token = sign_in_as(@user)

    assert_difference('Message.count', 1) do
      post api_messages_path, headers: { Authorization: token }, params: { message: { user_id: @user.id,
                                                  chatroom_id: @chatroom.id, message: 'How are you?' } }
    end
  end

  test 'should be able to see all the messages pertaining to the chatroom if logged in' do
    token = sign_in_as(@user)
    @message.save
    Message.create(user: @user, chatroom: @chatroom, message: 'how are you?')
    Message.create(user: @user, chatroom: @chatroom, message: 'how are you?')
    Message.create(user: @user, chatroom: @chatroom, message: 'how are you?')

    get api_messages_path, headers: { Authorization: token }, params: { chatroom_id: @chatroom.id }
    assert_response :success
  end

  test 'should not be able to get all messages if chatroom not provided' do
    token = sign_in_as(@user)
    get api_messages_path, headers: { Authorization: token }

    assert_response :missing
  end





end
