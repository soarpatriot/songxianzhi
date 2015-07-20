class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :openid
      t.string :nickname
      t.string :sex
      t.string :province
      t.string :city
      t.text :headimgurl
      t.string :unionid
    end
  end
end
