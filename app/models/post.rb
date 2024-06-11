class Post < ApplicationRecord
  has_one_attached :post_image

  belongs_to :user

  def self.looks(search, word)
    @post = Post.where("title LIKE?","%#{word}%")
  end

  validates :title, presence: true, length: { in: 2..30 }
  validates :body, presence: true
end
