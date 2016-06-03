class Topic < ActiveRecord::Base
  has_many :posts
  has_many :posts, dependent: :destroy
  has_many :sponsored_posts
  has_many :sponsored_posts, dependent: :destroy
end
