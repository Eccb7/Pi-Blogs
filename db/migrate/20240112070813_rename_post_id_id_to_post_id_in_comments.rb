class RenamePostIdIdToPostIdInComments < ActiveRecord::Migration[7.1]
  def change
    rename_column :comments, :post_id_id, :post_id
  end
end
