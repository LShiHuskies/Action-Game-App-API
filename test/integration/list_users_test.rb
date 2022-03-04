require 'test_helper'


class ListUsersTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: 'testing1', first_name: 'tester', last_name: 'tester', password: '12345678', email: 'test@example.com', activated: true)
    @user2 = User.create(username: 'testing2', first_name: 'tester', last_name: 'tester', password: '12345678', email: 'test@example.com', activated: true)
  end

  test 'should show list of users and only be able to viewed the appropriate user page' do
    token = sign_in_as(@user)

    get api_users_path, headers: { Authorization: token }
    assert_response :success

    assert_equal( JSON.parse(response.body).count, User.all.count, 'The length of the Users need to match' )

    User.all.each do |user|
      get api_user_path(user), headers: { Authorization: token }
      if user.id == @user.id
        assert_response :success
      else
        assert_response 401
      end
    end

  end


end
