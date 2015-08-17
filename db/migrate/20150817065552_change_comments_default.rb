class ChangeCommentsDefault < ActiveRecord::Migration
  def change
    change_column_default :comments, :created_at, nil
    change_column_default :comments, :updated_at, nil
  end
end
