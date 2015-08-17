class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.text :value
      t.timestamps
    end
  end
end
