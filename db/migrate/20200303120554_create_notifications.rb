class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id
      t.integer :visited_id
      t.integer :tweet_id
      t.integer :tweet_comment_id
      t.string :action, default: ''
      t.boolean :checked, default: false

      t.timestamps
    end

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :tweet_id
    add_index :notifications, :tweet_comment_id
  end
end
