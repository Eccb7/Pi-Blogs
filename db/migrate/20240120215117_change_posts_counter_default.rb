class ChangePostsCounterDefault < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :posts_counter, 0
  end
end
