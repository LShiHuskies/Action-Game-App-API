require 'test_helper'

class GameTest < ActiveSupport::TestCase

  def setup
    @game = Game.new()
  end

  test "Game needs a name" do
    assert_not @game.valid?
  end

  test "Game name must be at least 5 letters long" do
    @game.name = "test"

    assert_not @game.valid?
  end

  test "When Game name is at least 5 letters and less than 30 letters to be true" do
    @game.name = "Operation"

    assert @game.valid?
  end

  test "When Game name has over 30 letters to be invalid" do
    @game.name = "GAMEOVERTHELIMITWILLNOTWORKWHENOVER30LETTERS"

    assert_not @game.valid?
  end

  test "Game name must be unique" do
    @game.name = "hello"
    @game.save
    @game2 = Game.new(name: "hello")

    assert_not @game2.valid?
  end

  test "Game is not case sensitive" do
    @game.name = "hello"
    @game.save
    @game2 = Game.new(name: "Hello")

    assert_not @game2.valid?
  end

end
