class ChangeColumunActiveBackUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :active, from: true, to: false
  end
end
