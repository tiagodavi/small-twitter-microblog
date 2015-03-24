require 'rails_helper'

describe "the signup process", type: :feature do   
  it "User should be able to sign up" do
    visit '/signup'
    
    fill_in 'user_name',  :with => 'Example User'
    fill_in 'user_email', :with => 'user@example.com'
    fill_in 'user_login', :with => 'example'
    fill_in 'user_password', :with => '123'

    click_button 'Cadastrar'

    expect(page).to have_content 'Example User'
    expect(page).to have_content '@example'
  end
  it "User doesn't may register with invalid data" do
    visit '/signup'

    fill_in 'user_name',  :with => ''
    fill_in 'user_email', :with => 'invalid mail'
    fill_in 'user_login', :with => 'cachaça'
    fill_in 'user_password', :with => ''

    click_button 'Cadastrar'

    expect(page).to have_content 'não pode ficar em branco'
    expect(page).to have_content 'não é válido'
  end
end