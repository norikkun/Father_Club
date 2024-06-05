class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :user_image
  has_one_attached :post_image

  has_many :posts, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, length: { minimum: 6 }
end
