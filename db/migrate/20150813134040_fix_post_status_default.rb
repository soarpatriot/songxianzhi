class FixPostStatusDefault < ActiveRecord::Migration
  def change
    change_column :post, :status, :integer, default: Post.statuses[:sending] rescue nil
  end
end
