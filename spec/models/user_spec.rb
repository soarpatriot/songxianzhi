require 'rails_helper'

describe User, :type => :model do
  context "user post" do 
    it "create post" do 
      user = create :user 
      post = create :post
      user.posts << post

      expect(user.posts.size).to eq(1) 
    end
  end 
end
