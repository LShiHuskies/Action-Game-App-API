class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "GameChannel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # byebug
  end
end
