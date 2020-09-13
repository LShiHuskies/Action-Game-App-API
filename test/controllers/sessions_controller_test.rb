require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.new(username: 'testing1', first_name: 'tester', last_name: 'tester', password: '12345678', email: 'test@example.com')
  end

  test "should create session" do
    @user.save
    post login_path, params: { username: 'testing1', password: '12345678' }

    assert_response :success
  end

  test 'should not create session with improper credentials' do
    @user.save
    post login_path, params: { username: 'testing1', password: '12345678999' }

    assert_response 401
  end



end
