require 'rails_helper'

feature "Publish on Microblog" do

  background do
    @user = create(:user)

    visit '/signup'
    
    fill_in 'user_session_login',    :with => @user.login
    fill_in 'user_session_password', :with => @user.password
   
    click_button 'Entrar'
  end

  scenario "Valid user can to publish on Microblog" do
    
    post = "I arrived in guatemala on day of the dead, november first. I'm curious about this holiday!"
    
    fill_in 'tweet', with: post

    click_button 'Publicar'

    expect(page).to have_content post
  end

end