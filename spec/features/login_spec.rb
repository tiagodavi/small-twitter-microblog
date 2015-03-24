require 'rails_helper'

feature "Login" do

  background do
    @user = create(:user)
  end

  scenario "With correct credentials" do
    visit '/signup'
    
    fill_in 'user_session_login',    :with => @user.login
    fill_in 'user_session_password', :with => @user.password
   
    click_button 'Entrar'

    expect(page).to have_content 'John'
    expect(page).to have_content '@john'
  end

  scenario "With incorrect credentials" do
    visit '/signup'
    
    fill_in 'user_session_login',    :with => 'foo'
    fill_in 'user_session_password', :with => 'bar'
   
    click_button 'Entrar'

    expect(page).to have_content 'Login Inválido'
  end

end