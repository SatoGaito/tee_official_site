class TweetComment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  has_many :notifications, dependent: :destroy

  validates :tweet_id, :user_id, presence: true, on: :create
  validates :comment, presence: true, length: { maximum: 140 } 
end
