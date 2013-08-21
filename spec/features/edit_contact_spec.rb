require "feature_spec_helper"

feature "Edit Contact" do
  let!(:contact) { create(:contact) }

  scenario "User can edit a contact", js: true do
    home_page = load HomePage
    home_page.should be_displayed

    home_page.edit_contact(contact.name, {name: "Johnny Tan"})

    home_page.contacts.first.name.text.should  == "Johnny Tan"
  end
end
