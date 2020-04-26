class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  has_one_attached :p_image
  has_many :event_comments, dependent: :destroy
  has_many :tweet_comments, dependent: :destroy
  has_many :tweets, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 10}
  validates :nickname, :college, presence: true, length: { minimum: 2, maximum: 10 }, on: :update
  validates :grade, :gender, presence: true, on: :update
  validates :introduction, presence: true, length: { minimum: 5, maximum: 1000 }, on: :update

  def remember_me
    true
  end

  def email_required?
    false
  end
  
  def email_changed?
    false
  end

end
