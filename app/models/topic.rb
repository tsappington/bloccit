class Topic < ActiveRecord::Base
  has_many :posts
  has_many :posts, dependent: :destroy

  has_many :comments

  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings
end
