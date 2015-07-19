class User < ActiveRecord::Base

  acts_as_voter

  validates :email,  presence:true
  validates  :email, uniqueness: true
  validates :password, length: { minimum: 8 }, if: :password

  mount_uploader :avatar, UserAvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_one :shop
  has_many :information, as: :owner, dependent: :destroy

  after_create :set_random_avatar



  def nickname
    name.nil?? email: name
  end
  private
     def set_random_avatar
         self.update avatar: File.open("#{Rails.root.join('app/assets/images/avatars/')}noavatar.png")
     end



end
