class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  has_many :posts
  has_many :comments
  has_many :followings, foreign_key: 'follower_id', class_name: 'Follow'
  has_many :followers, foreign_key: 'following_id', class_name: 'Follow'

  def as_json(options = {})
    super(options.merge(except: [:encrypted_password]))
  end
end
