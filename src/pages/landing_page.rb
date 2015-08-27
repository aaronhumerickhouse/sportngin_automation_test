require_relative 'default_page'
require_relative 'boards_page'

#Page Object for the Landing Page
class LandingPage < DefaultPage

  page_url DefaultHelper.get_root_url
  title 'Kalmban'
  expected_element('a', {css: 'a.google.sign_in'}, 10)

  link(:google_sign_in, {css: 'a.google.sign_in'})
  link(:facebook_sign_in, {css: 'a.facebook.sign_in'})

  #Clicks login with google and logs in
  #@param [String] username
  #@param [String] password
  def sign_in_with_google(username, password)
    self.google_sign_in.click
    sleep 2
    $browser.send_keys username
    $browser.send_keys :enter
    sleep 2
    $browser.send_keys password
    $browser.send_keys :enter
    return BoardsPage.new $browser
  end
end
