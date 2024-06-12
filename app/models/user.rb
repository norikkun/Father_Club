class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :user_image
  
  def get_user_image(width, height)
    unless user_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      user_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      user_image.variant(resize_to_fill: [width, height]).processed
  end
  
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64(6) # 6文字以上のパスワードを生成
      user.password_confirmation = user.password # パスワード確認用に同じパスワードを設定
      user.name = "guestuser"
    end
  end
  
  def guest_user?
    email == GUEST_USER_EMAIL
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    @user = User.where("name LIKE?","%#{word}%")
  end

    validates :name, presence: true, uniqueness: true, length: { in: 2..10 }  
    validates :password, presence: true, length: { minimum: 6 }, if: -> { password.present? }
    validates :password_confirmation, presence: true, length: { minimum: 6 }, if: -> { password.present? }
end
