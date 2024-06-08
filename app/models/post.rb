class Post < ApplicationRecord
  has_one_attached :post_image
  
  belongs_to :user
  
  validates :title, presence: true, length: { in: 2..30 }  
  validates :body, presence: true
end
