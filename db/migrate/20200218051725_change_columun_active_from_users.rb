class ChangeColumunActiveFromUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :active, from: false, to: true
  end
end
