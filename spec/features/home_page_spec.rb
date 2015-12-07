require "spec_helper"

feature "Check Home Page", :type => :feature do
  
  scenario "Check Header" do
    visit "/"
    expect(page).to have_text("Helmuth Lab Database")
  end

  scenario "Has Map" do
  end

  scenario "Has Site" do
    visit "/"
    expect(page).to have_field('Site')
  end

  scenario "Has Country" do
    visit "/"
    expect(page).to have_select('country')
  end

  scenario "Has State" do
    visit "/"
    expect(page).to have_field('State/Province')
  end

  scenario "Has Zone" do
    visit "/"
    expect(page).to have_field('Zone')
  end

  scenario "Has SubZone" do
    visit "/"
    expect(page).to have_select('sub_zone')
  end
end
