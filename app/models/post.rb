class Post < ApplicationRecord
  has_one_attached :post_image
  
  validates :title, presence: true
  validates :body, presence: true
end
