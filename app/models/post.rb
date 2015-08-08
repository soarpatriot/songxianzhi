class Post < ActiveRecord::Base
  has_many :photos, as: :imageable
  has_many :comments, as: :commentable

  belongs_to :user

end
