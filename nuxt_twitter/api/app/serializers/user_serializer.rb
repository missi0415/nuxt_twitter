class UserSerializer < ActiveModel::Serializer
  attributes :id,:name
  has_many :posts
  has_many :comments
  has_many :like_posts
  has_many :like_comments
  has_many :followings, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, class_name: 'Relationship', foreign_key: :followed_id
end
