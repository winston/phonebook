require "feature_spec_helper"

feature "Delete a Contact" do
  let!(:contact) { create(:contact) }

  scenario "User can delete a contact" do
    home_page = load HomePage
    home_page.should be_displayed

    home_page.delete_contact(contact.name)
    home_page.wait_until_alert_invisible

    home_page.should have(0).contacts
  end
end
