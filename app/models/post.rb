class Post < ApplicationRecord
  has_one_attached :post_image

  belongs_to :user
  has_many :comments, dependent: :destroy

  def self.looks(search, word)
    @post = Post.where("title LIKE?","%#{word}%")
  end

  validates :title, presence: true, length: { in: 2..30 }
  validates :body, presence: true
end
