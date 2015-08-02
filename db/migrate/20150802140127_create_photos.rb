class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string  :image
      t.integer :imageable_id
      t.string  :imageable_type
      t.timestamps
    end
  end
end
