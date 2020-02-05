class RemoveEventImageIdFromEvent < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :event_image_id, :string
  end
end
