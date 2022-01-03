class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :favorites, dependent: :destroy
  has_many :books,dependent: :destroy
  has_many :book_comment,dependent: :destroy
  # フォロー
has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

# 一覧画面
has_many :followings, through: :relationships, source: :followed
has_many :followers, through: :reverse_of_relationships, source: :follower
  
  attachment :profile_image

  validates :name, length: {maximum: 20, minimum: 2}, uniqueness: true
  
  # フォローしたときの処理
def follow(user_id)
  
  relationships.create(followed_id: user_id)
end
# フォローを外すときの処理
def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
end
# フォローしているか判定
def following?(user)
    followings.include?(user)
end
def self.search(search,word)
    if search == "forward_match"
         @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
       　@user = User.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
         @user = User.where("#{word}")
    elsif search == "partial_match"
         @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
end
end
