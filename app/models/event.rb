class Event < ApplicationRecord
  attachment :event_image
  belongs_to :user
end
