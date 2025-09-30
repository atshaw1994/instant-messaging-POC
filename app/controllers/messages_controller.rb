# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.new(message_params)
    @message.user = current_user

    if @message.save
      # Broadcast the new message data to the chat channel
      ActionCable.server.broadcast(
        "chat_#{@chat.id}",
        {
          body: @message.body,
          sender_id: @message.user_id,
          sender_name: @message.user.display_name,
          message_id: @message.id
        }
      )
      head :ok
    else
      # Handle validation errors if necessary
      render 'chats/show', status: :unprocessable_entity, locals: { current_user_id: current_user.id }
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end