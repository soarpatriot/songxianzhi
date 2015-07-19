class Comment < ActiveRecord::Base

  default_scope {order("id desc")}

  validates :content, presence:true

  belongs_to :user
  belongs_to :commentable, polymorphic: true

end
