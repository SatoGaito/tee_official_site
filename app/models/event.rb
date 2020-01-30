class Event < ApplicationRecord
  attachment :event_image
  belongs_to :user
  has_many :event_comments, dependent: :destroy
end
