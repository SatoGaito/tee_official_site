class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|

      t.string :title
      t.date :date
      t.text :content
      t.string :event_image_id
      t.timestamps
    end
  end
end
