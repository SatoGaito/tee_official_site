class Event < ApplicationRecord
  attachment :event_image
  belongs_to :user
  has_many :event_comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 12 }
  validates :content, presence: true, length: { minimum: 20, maximum: 300 }
  validates :event_image_id, :date, :user_id, presence: true
end
