class RenameUserIdIdToUserIdInLikes < ActiveRecord::Migration[7.1]
  def change
    rename_column :likes, :user_id_id, :user_id
  end
end
