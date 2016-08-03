class User < ActiveRecord::Base

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  before_save { self.email = email.downcase if email.present? }
  before_save { self.role ||= :member }

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }, unless: :password_digest
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  has_secure_password

  enum role: [:member, :admin]

  def favorite_for(post)
    favorites.where(post_id: post.id).first
  end

  def favorite_posts
    user_favorites = []
    favorites.each do |fav|
        user_favorites << fav.post
    end
    user_favorites
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def post_and_comment
    self.comments.count + self.posts.count
  end

end
