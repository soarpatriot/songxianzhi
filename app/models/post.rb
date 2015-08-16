class Post < ActiveRecord::Base
  
  enum status: [:sending,:sent]
  acts_as_votable

  validates :description, presence:true
  has_many :photos, as: :imageable
  has_many :comments, as: :commentable
  validates :photos, presence:true

  belongs_to :user
  
  def chinese_status
    if self.sending?
      "正在送"
    else 
      "已送出"
    end
  end
end
