
class HomePage < SitePrism::Page
  class ContactSection < SitePrism::Section
    element :name       , "[data-test-name=contact_name]"
    element :delete_link, "[data-test-name=delete_link]"
  end

  set_url "/"
  set_url_matcher /\/$/

  # Alert
  element :alert, "[data-test-name=alert]"

  # Contacts
  sections :contacts, ContactSection, "[data-test-name=contact]"

  # Form
  element :contact_name_field , "[data-test-name=contact_name_field]"
  element :contact_phone_field, "[data-test-name=contact_phone_field]"

  def add_contact(name, phone)
    contact_name_field.set  name
    contact_phone_field.set phone
    click_on "Add Contact"
  end

  def delete_contact(name)
    contact = contacts.find { |contact| contact.name.text == name }
    contact.delete_link.click
  end
end

