require 'test_helper'

class NotifierMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(username: 'testing1', first_name: 'tester', last_name: 'tester', password: '12345678', email: 'shi.louis2@gmail.com')
    @game = Game.new(name: 'New Game')
  end
  # we need to ensure that the the default email is correct
  # we need to make sure that the correct email is being sent out for the appropriate users

  test "welcome_email" do
    # Create the email and store it for further assertions
    email = NotifierMailer.welcome_email(@user).deliver_now

    assert_equal [ENV['DEFAULTEMAIL']], email.from
    assert_equal [@user.email], email.to
    assert_equal "Welcome to The Game!", email.subject
  end

  test "reset_email" do
    # Create the email and store it for further assertions
    email = NotifierMailer.reset_email(@user).deliver_now

    assert_equal [ENV['DEFAULTEMAIL']], email.from
    assert_equal [@user.email], email.to
    assert_equal "Password Reset", email.subject
  end

  test "update_account_notify" do
    email = NotifierMailer.update_account_notify(@user).deliver_now

    assert_equal [ENV['DEFAULTEMAIL']], email.from
    assert_equal [@user.email], email.to
    assert_equal "Account Updated", email.subject
  end

end
