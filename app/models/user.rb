class User < ApplicationRecord

  attr_accessor:remember_token

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  has_one_attached :p_image
  has_many :event_comments, dependent: :destroy
  has_many :tweet_comments, dependent: :destroy
  has_many :tweets, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 10}
  validates :nickname, :college, presence: true, length: { minimum: 2, maximum: 10 }, on: :update
  validates :grade, :gender, presence: true, on: :update
  validates :introduction, presence: true, length: { minimum: 50, maximum: 1000 }, on: :update

  def email_required?
    false
  end
  def email_changed?
    false
  end

end
