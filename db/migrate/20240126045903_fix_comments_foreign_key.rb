class FixCommentsForeignKey < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :comments, column: :post_id
    add_foreign_key :comments, :posts, column: :post_id
  end
end
