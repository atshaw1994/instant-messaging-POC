# app/controllers/chats_controller.rb
class ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Load all chats where the current user is either the sender or receiver
    @chats = Chat.where(sender: current_user).or(Chat.where(receiver: current_user)).order(updated_at: :desc)
    @users = User.all_except(current_user) # To show a list of users to start a chat with
  end

  def show
    @chat = Chat.find(params[:id])
    @message = @chat.messages.new
    # Ensure only participants can view the chat
    unless @chat.sender == current_user || @chat.receiver == current_user
      redirect_to chats_path, alert: "You are not a participant in this chat."
    end
  end

  def create
    # Find the user the current user wants to chat with
    @receiver = User.find(params[:user_id] || chat_params[:receiver_id])

    # 1. Try to find an existing chat between the two users
    @chat = Chat.between(current_user, @receiver).first

    if @chat.nil?
      # 2. If no chat exists, create a new one
      @chat = Chat.new(sender: current_user, receiver: @receiver)
      if @chat.save
        flash[:notice] = "Chat started with #{@receiver.display_name}!"
      else
        redirect_to chats_path, alert: "Could not start chat." and return
      end
    end

    redirect_to @chat
  end

  def new
    @users = User.all_except(current_user) # To select a user to chat with
    @chat = Chat.new
  end

  private

  def chat_params
    params.require(:chat).permit(:receiver_id)
  end
end