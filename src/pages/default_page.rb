require_relative 'page_object'
require_relative '../helpers/default_helper'

#Class for page objects on common pages
class DefaultPage < PageObject
  link(:home, id: 'home')
  link(:about, id: 'about')
  link(:contact, id: 'contact')
  link(:privacy_policy, id: 'privacy')
  link(:sign_out_link, css: 'div#sign_out > a')

  div(:about_modal, css: 'div#about_modal')
  div(:contact_modal, css: 'div#contact_modal')
  div(:privacy_modal, css: 'div#privacy_modal')

  button(:close_about_modal, css: 'div#about_modal button.close')
  button(:close_contact_modal, css: 'div#about_contact button.close')
  button(:close_privacy_modal, css: 'div#about_privacy button.close')

  # Clicks the Home link in the footer
  def navigate_to_home
    self.home.when_present.click
  end

  # Clicks the About link in the footer
  def open_about_modal
    self.about.when_present.click
  end

  # Clicks the Contact link in the footer
  def open_contact_modal
    self.contact.when_present.click
  end

  # Clicks the Privacy Policy link in the footer
  def open_privacy_policy_modal
    self.privacy_policy.when_present.click
  end


  # Clicks Sign out
  def sign_out
    self.sign_out_link.when_present.click
  end
end
