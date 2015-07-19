module Authorize

  def login

    user = create(:user, email:"aaa@126.com")
    visit new_user_session_path

    within("#new_user") do

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password

    end  

    click_button "登陆"
    expect(page).to have_content(user.email)

  end

end