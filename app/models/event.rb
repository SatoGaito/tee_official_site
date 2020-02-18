class Event < ApplicationRecord

  has_one_attached :e_image
  has_many :event_comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 12 }
  validates :content, presence: true, length: { minimum: 20, maximum: 1000 }
  validates :date, presence: true
end
