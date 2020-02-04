class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attachment :profile_image
  has_many :event_comments, dependent: :destroy
  has_many :events

  validates :name, :nickname, :college, presence: true, length: { minimum: 2, maximum: 10 }, on: :update
  validates :grade, :gender, presence: true, on: :update
  validates :introduction, presence: true, length: { minimum: 50, maximum: 300 }, on: :update
end
