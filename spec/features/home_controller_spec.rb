require 'rails_helper'


describe HomeController, :type => :feature do

  describe "GET 'index'" do
    it "to home page"  ,js: true do

      visit "/"
      expect(page).to have_content("商店")
      login
    end
  end
end
