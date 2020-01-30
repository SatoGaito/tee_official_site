class CreateEventComments < ActiveRecord::Migration[5.2]
  def change
    create_table :event_comments do |t|

      t.text :comment
      t.integer :event_id
      t.integer :user_id
      t.timestamps
    end
  end
end
