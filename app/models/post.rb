class Post < ApplicationRecord

  has_many :routes, dependent: :destroy
  accepts_nested_attributes_for :routes
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  # publishedカラムはtrueかfalseで公開・非公開を管理
  scope :published, -> { where(status: true) }

  belongs_to :user

  # updateの時だけvalidationを実行させる
  validates :title, presence: true, on: :update
  

end
