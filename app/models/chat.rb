class Chat < ApplicationRecord
  # A chat belongs to two users, an explicitly defined sender and receiver
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  has_many :messages, dependent: :destroy

  # Scope to find a chat between two users regardless of who is sender/receiver
  scope :between, ->(user_a, user_b) {
    where(
      "(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)",
      user_a.id, user_b.id, user_b.id, user_a.id
    )
  }
end