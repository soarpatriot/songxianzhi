class Post < ActiveRecord::Base
  has_many :photos, as: :imageable
end
