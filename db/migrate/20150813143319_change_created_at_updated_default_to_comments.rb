class ChangeCreatedAtUpdatedDefaultToComments < ActiveRecord::Migration
  def change
    change_column :comments, :created_at, :datetime, default: Time.now rescue nil
    change_column :comments, :updated_at, :datetime, default: Time.now rescue nil
  end
end
