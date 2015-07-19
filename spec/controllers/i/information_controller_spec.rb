=begin
require "rails_helper"

RSpec.describe I::InformationController, :type => :controller do
  describe "GET #index" do
    render_views
    it "responds successfully with an HTTP 200 status code" do
      get i_information_index_path
      expect(response).to be_success
      # expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get i_information_index_path

      # expect(body).to match /我的信息/
      # expect(response).to render_template(:index)
    end



    it "loads all of the posts into @posts" do
      post1, post2 = Post.create!, Post.create!
      get :index

      expect(assigns(:posts)).to match_array([post1, post2])
    end


  end
end
=end
