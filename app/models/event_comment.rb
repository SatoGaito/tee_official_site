class EventComment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :event_id, :user_id, presence: true, on: :create
  validates :comment, presence: true, length: { maximum: 140 } 
end
