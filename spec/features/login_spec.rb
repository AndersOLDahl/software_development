require "spec_helper"

feature "Login Management", :type => :feature do
  User.new(:email => "user@name.com", :password => 'password', :password_confirmation => 'password').save

  scenario "User login  Success" do
    visit "/"
    click_link('Log In')
    fill_in "Email", :with => "user@name.com"
    fill_in "Password", :with => "password"
    click_button('Log in')
    expect(page).to have_text("Signed in successfully.")  
    click_link('Log Out')
    expect(page).to have_text("Signed out successfully.")
  end

  scenario "User login Fail" do
    visit "/"
    click_link('Log In')
    fill_in "Email", :with => "fart@farting.com"
    fill_in "Password", :with => "farts"
    click_button('Log in')
    expect(page).to have_text("Invalid email or password.")
  end
end
