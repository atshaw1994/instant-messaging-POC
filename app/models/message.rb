class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validates :body, presence: true

  # 🌟 The magic for real-time updates! 🌟
  # After a message is saved to the database, it automatically
  # broadcasts a Turbo Stream action to clients subscribed to the chat.
  after_create_commit -> {
    broadcast_append_to chat, target: "messages", partial: "messages/message", locals: { current_user: user }
  }
end