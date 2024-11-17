class PrivateChatChannel < ApplicationCable::Channel
  def subscribed
    # Stream from a specific chat room based on user IDs
    stream_from "private_chat_#{params[:user_id]}_#{params[:recipient_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)

    Rails.logger.fatal "^^^^^^^^^^^^^^^^^data^^^^^^^^^^^^^^^^^^^^^^#{data}"
    # Broadcast the message to the specific chat room
    ActionCable.server.broadcast("private_chat_#{data['recipient_id']}_#{data['user_id']}", { message: data['message'], user: data['user_id'] })
  end
end
