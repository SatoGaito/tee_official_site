class Tweet < ApplicationRecord
  belongs_to :user
  has_many :tweet_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_one_attached :t_image

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :tweet, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  def create_notification_like(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and tweet_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        tweet_id: id,
        visited_id: user_id,
        action: 'like'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_tweet_comment(current_user, tweet_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = TweetComment.select(:user_id).where(tweet_id: id).where.not(user_id: current_user.id).where.not(user_id: user_id).distinct
    temp_ids.each do |temp_id|
      save_notification_tweet_comment(current_user, tweet_comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_tweet_comment(current_user, tweet_comment_id, user_id)
  end

  def save_notification_tweet_comment(current_user, tweet_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      tweet_id: id,
      tweet_comment_id: tweet_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
