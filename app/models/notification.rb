class Notification < ApplicationRecord

  belongs_to :subject, polymorphic: true
  belongs_to :user
  
  scope :unread, -> { where(read_at: nil) }

  enum action_type: { commented_to_own_post: 0, liked_to_own_post: 1, followed_me: 3}

end