require "spec_helper"

feature "Login Management", :type => :feature do
  User.new(:email => "user@name.com", :password => 'password', :password_confirmation => 'password').save

  scenario "User login" do
    visit "/"

    click_link('Login')
    fill_in "Email", :with => "user@name.com"
    fill_in "Password", :with => "password"
    click_button('Log in')
    expect(page).to have_text("Signed in successfully.")
  end
end
