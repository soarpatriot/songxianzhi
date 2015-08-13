class Post < ActiveRecord::Base
  
  enum status: [:sending,:sent]
  acts_as_votable

  has_many :photos, as: :imageable
  has_many :comments, as: :commentable

  belongs_to :user

end
