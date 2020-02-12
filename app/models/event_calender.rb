class EventCalender < ApplicationRecord

  validates :title, presence: true, length: { maximum: 12 }
  validates :content, presence: true, length: { minimum: 20, maximum: 1000 }
  validates :start_time, presence: true
end
