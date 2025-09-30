class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :messages

  # Chats where the user is the sender
  has_many :sent_chats, class_name: "Chat", foreign_key: "sender_id", dependent: :destroy
  # Chats where the user is the receiver
  has_many :received_chats, class_name: "Chat", foreign_key: "receiver_id", dependent: :destroy

  # A helper method to display a name or email
  def display_name
    email.split('@').first
  end

  # Returns all users except the given user
  def self.all_except(user)
    where.not(id: user.id)
  end
end
