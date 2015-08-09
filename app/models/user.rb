class User < ActiveRecord::Base

  acts_as_voter
  has_many :posts

end
