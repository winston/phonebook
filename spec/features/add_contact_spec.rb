require "feature_spec_helper"

feature "Add Contact" do
  scenario "User can add a contact", js: true do
    home_page = load HomePage
    home_page.should be_displayed

    home_page.add_contact("John", "67654321")
    home_page.wait_for_contacts

    home_page.should have(1).contacts
    home_page.contacts.first.name.text.should  == "John"
  end
end
