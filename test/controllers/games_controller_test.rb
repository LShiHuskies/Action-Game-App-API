require 'test_helper'



class GamesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.new(username: 'testing1', first_name: 'tester', last_name: 'tester', password: '12345678', email: 'test@example.com')
    @game = Game.new(name: 'New Game')
  end

  test 'The user needs to be logged to see all game' do
    get api_games_path

    assert_response 401
  end

  test 'The user will be able to see all games if logged in' do
    @user.save
    token = sign_in_as(@user)

    get api_games_path, headers: { Authorization: token }

    assert_response :success
  end

  test 'does not create a new game when the attributes are not valid' do
    @user.save
    token = sign_in_as(@user)

    post api_games_path, headers: { Authorization: token }, params: { game: { name: '' } }
    assert_response :missing
  end

  test 'does create a new game when the attributes are valid' do
    @user.save
    token = sign_in_as(@user)

    post api_games_path, headers: { Authorization: token }, params: { game: { name: 'New Game' } }
    assert_response :success
  end


  test 'does update a game when the attributes are valid' do
    @user.save
    @game.save
    token = sign_in_as(@user)

    put api_game_path(@game), headers: { Authorization: token }, params: { game: { name: 'Updated Game!' } }
    assert_response :success
  end


  test 'does not update a game when the attributes are not valid' do
    @user.save
    @game.save
    token = sign_in_as(@user)

    put api_game_path(@game), headers: { Authorization: token }, params: { game: { name: '' } }
    assert_response 401
  end


end
