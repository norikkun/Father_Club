class Post < ApplicationRecord
  has_one_attached :post_image

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def favorited_by?(user)
    return false unless user
    favorites.exists?(user_id: user.id)
  end

  def self.looks(word)
    @post = Post.where("title LIKE?", "%#{word}%")
  end

  validates :title, presence: true, length: { in: 2..30 }
  validates :body, presence: true
end
