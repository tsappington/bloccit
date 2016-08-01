class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings

   default_scope { order('rank DESC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  after_create :favorite_own_post

  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end

  private  # I see this is not necessary, but I don't know why.

  def favorite_own_post
    # This is all I could think to do.  I see the video is passing post & user arguments.
    # But I didn't think the create method accepted arguments.
    # -------------------------
    # Favorite.create
    # FavoriteMailer.new_post

    # VIDEO SOLUTION
    Favorite.create(post: self, user: self.user)
    FavoriteMailer.new_post(self).deliver_now
  end


end
