class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :user_image

  has_many :posts, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { in: 2..10 }  
   validates :password, presence: true, length: { minimum: 6 }, if: -> { password.present? }
   validates :password_confirmation, presence: true, length: { minimum: 6 }, if: -> { password.present? }
end
