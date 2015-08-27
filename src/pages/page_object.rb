 #The base page for all Automation Test pages
class PageObject
  # Initializes a page, verifies title, url, and expected element exist prior to continuing.
  def initialize(browser)
    $browser = browser
    expected_element if respond_to? :expected_element
    at? if respond_to? :at?
    has_expected_title? if respond_to? :has_expected_title?
  end

  # Called when a method is not defined by GenericBasePage.  Sends the call up to Selenium
  def method_missing sym, *args, &block
    $browser.send sym, *args, &block
  end

  # Creates the at? method.  The dynamic method checks if the page url matches the page object url.
  # @param url [String, Regexp] The expected URL of the page
  def self.page_url(url)
    define_method 'at?' do
      $browser.wait_until(nil, "Not at url #{url}, but instead #{$browser.url}") { url.kind_of?(Regexp) ? url =~ $browser.url : url == $browser.url }
    end
  end

  # Creates the expected_element? method to each page object.  Waits until the the element from the the page object
  # is present.  If it doesn't, raise an exception.
  # @param type [String] The expected element type.
  # @param identifier [Hash] Information to find the expected element.
  # @param timeout [Integer] The length of time to wait before timeout.
  # @example
  #   expected_element('link', {css: 'a.button.save', index: 0}, 15)
  def self.expected_element(type, identifier, timeout=Watir.default_timeout)
    define_method 'expected_element' do
      $browser.send("#{type.to_s}", identifier).wait_until_present timeout
    end
  end

  # Creates the has_expected_title? method to each page object.  Verifies the title matches the given title from the
  # page object.  If it doesn't, raise an exception.
  # @param title [String] The head title of page
  def self.title(title)
    define_method 'has_expected_title?' do
      has_expected_title = title.kind_of?(Regexp) ? title =~ $browser.title : title == $browser.title
      raise "Expected title '#{title}' instead of '#{$browser.title}'" unless has_expected_title
    end
  end


  ################################## DYNAMIC METHOD CREATION FOR BASE WATIR ELEMENTS ##################################

  # For each element() defined in the page object these methods are added:
  # * <name> - Returns the element
  # @param element_name [String] The desired name for the new element.
  # @param selector [Hash] The selector for the new element.
  def self.element(element_name, selector)
    define_method element_name.to_s do
      $browser.element(selector)
    end
  end

  # For each area() defined in the page object these methods are added:
  # * <name> - Returns the area
  # @param element_name [String] The desired name for the new area.
  # @param selector [Hash] The selector for the new area.
  def self.area(element_name, selector)
    define_method element_name.to_s do
      $browser.area(selector)
    end
  end

  # For each button() defined in the page object these methods are added:
  # * <name> - Returns the button
  # @param element_name [String] The desired name for the new button.
  # @param selector [Hash] The selector for the new button.
  def self.button(element_name, selector)
    define_method element_name.to_s do
      $browser.button(selector)
    end
  end

  # For each checkbox() defined in the page object these methods are added:
  # * <name> - Returns the checkbox
  # @param element_name [String] The desired name for the new checkbox.
  # @param selector [Hash] The selector for the new checkbox.
  def self.checkbox(element_name, selector)
    define_method element_name.to_s do
      $browser.checkbox(selector)
    end
  end

  # For each dlist() defined in the page object these methods are added:
  # * <name> - Returns the dlist
  # @param element_name [String] The desired name for the new dlist.
  # @param selector [Hash] The selector for the new dlist.
  def self.dlist(element_name, selector)
    define_method element_name.to_s do
      $browser.dlist(selector)
    end
  end

  # For each file_field() defined in the page object these methods are added:
  # * <name> - Returns the file_field
  # @param element_name [String] The desired name for the new file_field.
  # @param selector [Hash] The selector for the new file_field.
  def self.file_field(element_name, selector)
    define_method element_name.to_s do
      $browser.file_field(selector)
    end
  end

  # For each font() defined in the page object these methods are added:
  # * <name> - Returns the font
  # @param element_name [String] The desired name for the new font.
  # @param selector [Hash] The selector for the new font.
  def self.font(element_name, selector)
    define_method element_name.to_s do
      $browser.font(selector)
    end
  end

  # For each form() defined in the page object these methods are added:
  # * <name> - Returns the form
  # @param element_name [String] The desired name for the new form.
  # @param selector [Hash] The selector for the new form.
  def self.form(element_name, selector)
    define_method element_name.to_s do
      $browser.form(selector)
    end
  end

  # For each hidden() defined in the page object these methods are added:
  # * <name> - Returns the hidden
  # @param element_name [String] The desired name for the new hidden.
  # @param selector [Hash] The selector for the new hidden.
  def self.hidden(element_name, selector)
    define_method element_name.to_s do
      $browser.hidden(selector)
    end
  end

  # For each iframe() defined in the page object these methods are added:
  # * <name> - Returns the iframe
  # @param element_name [String] The desired name for the new iframe.
  # @param selector [Hash] The selector for the new iframe.
  def self.iframe(element_name, selector)
    define_method element_name.to_s do
      $browser.iframe(selector)
    end
  end

  # For each image() defined in the page object these methods are added:
  # * <name> - Returns the image
  # @param element_name [String] The desired name for the new image.
  # @param selector [Hash] The selector for the new image.
  def self.image(element_name, selector)
    define_method element_name.to_s do
      $browser.image(selector)
    end
  end

  # For each input() defined in the page object these methods are added:
  # * <name> - Returns the input
  # @param element_name [String] The desired name for the new input.
  # @param selector [Hash] The selector for the new input.
  def self.input(element_name, selector)
    define_method element_name.to_s do
      $browser.input(selector)
    end
  end

  # For each link() defined in the page object these methods are added:
  # * <name> - Returns the link
  # @param element_name [String] The desired name for the new link.
  # @param selector [Hash] The selector for the new link.
  def self.link(element_name, selector)
    define_method element_name.to_s do
      $browser.link(selector)
    end
  end

  # For each option() defined in the page object these methods are added:
  # * <name> - Returns the option
  # @param element_name [String] The desired name for the new option.
  # @param selector [Hash] The selector for the new option.
  def self.option(element_name, selector)
    define_method element_name.to_s do
      $browser.option(selector)
    end
  end

  # For each radio() defined in the page object these methods are added:
  # * <name> - Returns the radio
  # @param element_name [String] The desired name for the new radio.
  # @param selector [Hash] The selector for the new radio.
  def self.radio(element_name, selector)
    define_method element_name.to_s do
      $browser.radio(selector)
    end
  end

  # For each select() defined in the page object these methods are added:
  # * <name> - Returns the select
  # @param element_name [String] The desired name for the new select.
  # @param selector [Hash] The selector for the new select.
  def self.select(element_name, selector)
    define_method element_name.to_s do
      $browser.select(selector)
    end
  end

  # For each table() defined in the page object these methods are added:
  # * <name> - Returns the table
  # @param element_name [String] The desired name for the new table.
  # @param selector [Hash] The selector for the new table.
  def self.table(element_name, selector)
    define_method element_name.to_s do
      $browser.table(selector)
    end
  end

  # For each table_cell() defined in the page object these methods are added:
  # * <name> - Returns the table_cell
  # @param element_name [String] The desired name for the new table_cell.
  # @param selector [Hash] The selector for the new table_cell.
  def self.table_cell(element_name, selector)
    define_method element_name.to_s do
      $browser.table_cell(selector)
    end
  end

  # For each td() defined in the page object these methods are added:
  # * <name> - Returns the td
  # @param element_name [String] The desired name for the new td.
  def self.td(element_name, selector)
    define_method element_name.to_s do
      $browser.td(selector)
    end
  end

  # For each table_row() defined in the page object these methods are added:
  # * <name> - Returns the table_row
  # @param element_name [String] The desired name for the new table_row.
  # @param selector [Hash] The selector for the new table_row.
  def self.tr(element_name, selector)
    define_method element_name.to_s do
      $browser.tr(selector)
    end
  end


  # For each table_section() defined in the page object these methods are added:
  # * <name> - Returns the table_section
  # @param element_name [String] The desired name for the new table_section.
  # @param selector [Hash] The selector for the new table_section.
  def self.table_section(element_name, selector)
    define_method element_name.to_s do
      $browser.table_section(selector)
    end
  end

  # For each text_area() defined in the page object these methods are added:
  # * <name> - Returns the text_area
  # @param element_name [String] The desired name for the new text_area.
  # @param selector [Hash] The selector for the new text_area.
  def self.text_area(element_name, selector)
    define_method element_name.to_s do
      $browser.textarea(selector)
    end
  end

  # For each text_field() defined in the page object these methods are added:
  # * <name> - Returns the text_field
  # @param element_name [String] The desired name for the new text_field.
  # @param selector [Hash] The selector for the new text_field.
  def self.text_field(element_name, selector)
    define_method element_name.to_s do
      $browser.text_field(selector)
    end
  end


  # For each elements() defined in the page object these methods are added:
  # * <name> - Returns an array of matching elements
  # @param element_name [String] The desired name for the new element.
  # @param selector [Hash] The selector for the new element.
  def self.elements(element_name, selector)
    define_method element_name.to_s do
      $browser.elements(selector)
    end
  end

  # For each areas() defined in the page object these methods are added:
  # * <name> - Returns an array of matching areas
  # @param element_name [String] The desired name for the new area.
  # @param selector [Hash] The selector for the new area.
  def self.areas(element_name, selector)
    define_method element_name.to_s do
      $browser.areas(selector)
    end
  end

  # For each buttons() defined in the page object these methods are added:
  # * <name> - Returns an array of matching buttons
  # @param element_name [String] The desired name for the new button.
  # @param selector [Hash] The selector for the new button.
  def self.buttons(element_name, selector)
    define_method element_name.to_s do
      $browser.buttons(selector)
    end
  end

  # For each checkboxes() defined in the page object these methods are added:
  # * <name> - Returns an array of matching checkboxes
  # @param element_name [String] The desired name for the new checkbox.
  # @param selector [Hash] The selector for the new checkbox.
  def self.checkboxes(element_name, selector)
    define_method element_name.to_s do
      $browser.checkboxes(selector)
    end
  end

  # For each dlists() defined in the page object these methods are added:
  # * <name> - Returns an array of matching dlists
  # @param element_name [String] The desired name for the new dlist.
  # @param selector [Hash] The selector for the new dlist.
  def self.dlists(element_name, selector)
    define_method element_name.to_s do
      $browser.dlists(selector)
    end
  end

  # For each file_fields() defined in the page object these methods are added:
  # * <name> - Returns an array of matching file_fields
  # @param element_name [String] The desired name for the new file_field.
  # @param selector [Hash] The selector for the new file_field.
  def self.file_fields(element_name, selector)
    define_method element_name.to_s do
      $browser.file_fields(selector)
    end
  end

  # For each fonts() defined in the page object these methods are added:
  # * <name> - Returns an array of matching fonts
  # @param element_name [String] The desired name for the new font.
  # @param selector [Hash] The selector for the new font.
  def self.fonts(element_name, selector)
    define_method element_name.to_s do
      $browser.fonts(selector)
    end
  end

  # For each forms() defined in the page object these methods are added:
  # * <name> - Returns an array of matching forms
  # @param element_name [String] The desired name for the new form.
  # @param selector [Hash] The selector for the new form.
  def self.forms(element_name, selector)
    define_method element_name.to_s do
      $browser.forms(selector)
    end
  end

  # For each hiddens() defined in the page object these methods are added:
  # * <name> - Returns an array of matching hiddens
  # @param element_name [String] The desired name for the new hidden.
  # @param selector [Hash] The selector for the new hidden.
  def self.hiddens(element_name, selector)
    define_method element_name.to_s do
      $browser.hiddens(selector)
    end
  end

  # For each iframes() defined in the page object these methods are added:
  # * <name> - Returns an array of matching iframes
  # @param element_name [String] The desired name for the new iframe.
  # @param selector [Hash] The selector for the new iframe.
  def self.iframes(element_name, selector)
    define_method element_name.to_s do
      $browser.iframes(selector)
    end
  end

  # For each images() defined in the page object these methods are added:
  # * <name> - Returns an array of matching images
  # @param element_name [String] The desired name for the new image.
  # @param selector [Hash] The selector for the new image.
  def self.images(element_name, selector)
    define_method element_name.to_s do
      $browser.images(selector)
    end
  end

  # For each inputs() defined in the page object these methods are added:
  # * <name> - Returns an array of matching inputs
  # @param element_name [String] The desired name for the new input.
  # @param selector [Hash] The selector for the new input.
  def self.inputs(element_name, selector)
    define_method element_name.to_s do
      $browser.inputs(selector)
    end
  end

  # For each links() defined in the page object these methods are added:
  # * <name> - Returns an array of matching links
  # @param element_name [String] The desired name for the new link.
  # @param selector [Hash] The selector for the new link.
  def self.links(element_name, selector)
    define_method element_name.to_s do
      $browser.links(selector)
    end
  end

  # For each options() defined in the page object these methods are added:
  # * <name> - Returns an array of matching options
  # @param element_name [String] The desired name for the new option.
  # @param selector [Hash] The selector for the new option.
  def self.options(element_name, selector)
    define_method element_name.to_s do
      $browser.options(selector)
    end
  end

  # For each radios() defined in the page object these methods are added:
  # * <name> - Returns an array of matching radios
  # @param element_name [String] The desired name for the new radio.
  # @param selector [Hash] The selector for the new radio.
  def self.radios(element_name, selector)
    define_method element_name.to_s do
      $browser.radios(selector)
    end
  end

  # For each selects() defined in the page object these methods are added:
  # * <name> - Returns an array of matching selects
  # @param element_name [String] The desired name for the new select.
  # @param selector [Hash] The selector for the new select.
  def self.selects(element_name, selector)
    define_method element_name.to_s do
      $browser.selects(selector)
    end
  end

  # For each tables() defined in the page object these methods are added:
  # * <name> - Returns an array of matching tables
  # @param element_name [String] The desired name for the new table.
  # @param selector [Hash] The selector for the new table.
  def self.tables(element_name, selector)
    define_method element_name.to_s do
      $browser.tables(selector)
    end
  end

  # For each table_cells() defined in the page object these methods are added:
  # * <name> - Returns an array of matching table_cells
  # @param element_name [String] The desired name for the new table_cell.
  # @param selector [Hash] The selector for the new table_cell.
  def self.table_cells(element_name, selector)
    define_method element_name.to_s do
      $browser.table_cells(selector)
    end
  end

  # For each tds() defined in the page object these methods are added:
  # * <name> - Returns an array of matching tds
  # @param element_name [String] The desired name for the new td.
  # @param selector [Hash] The selector for the new td.
  def self.tds(element_name, selector)
    define_method element_name.to_s do
      $browser.tds(selector)
    end
  end

  # For each table_rows() defined in the page object these methods are added:
  # * <name> - Returns an array of matching table_rows
  # @param element_name [String] The desired name for the new table_row.
  # @param selector [Hash] The selector for the new table_row.
  def self.trs(element_name, selector)
    define_method element_name.to_s do
      $browser.trs(selector)
    end
  end

  # For each table_sections() defined in the page object these methods are added:
  # * <name> - Returns an array of matching table_sections
  # @param element_name [String] The desired name for the new table_section.
  # @param selector [Hash] The selector for the new table_section.
  def self.table_sections(element_name, selector)
    define_method element_name.to_s do
      $browser.table_sections(selector)
    end
  end

  # For each text_areas() defined in the page object these methods are added:
  # * <name> - Returns an array of matching text_areas
  # @param element_name [String] The desired name for the new text_area.
  # @param selector [Hash] The selector for the new text_area.
  def self.text_areas(element_name, selector)
    define_method element_name.to_s do
      $browser.textareas(selector)
    end
  end

  # For each text_fields() defined in the page object these methods are added:
  # * <name> - Returns an array of matching text_fields
  # @param element_name [String] The desired name for the new text_field.
  # @param selector [Hash] The selector for the new text_field.
  def self.text_fields(element_name, selector)
    define_method element_name.to_s do
      $browser.text_fields(selector)
    end
  end

  # For each h1() defined in the page object these methods are added:
  # * <name> - Returns the first matching h1
  # @param element_name [String] The desired name for the new h1.
  # @param selector [Hash] The selector for the new h1.
  def self.h1(element_name, selector)
    define_method element_name.to_s do
      $browser.h1(selector)
    end
  end

  # For each h1s() defined in the page object these methods are added:
  # * <name> - Returns an array of matching h1s
  # @param element_name [String] The desired name for the new h1s.
  # @param selector [Hash] The selector for the new h1s.
  def self.h1s(element_name, selector)
    define_method element_name.to_s do
      $browser.h1s(selector)
    end
  end

  # For each h1() defined in the page object these methods are added:
  # * <name> - Returns the first matching h2
  # @param element_name [String] The desired name for the new h2.
  # @param selector [Hash] The selector for the new h2.
  def self.h2(element_name, selector)
    define_method element_name.to_s do
      $browser.h2(selector)
    end
  end

  # For each h2s() defined in the page object these methods are added:
  # * <name> - Returns an array of matching h2s
  # @param element_name [String] The desired name for the new h2s.
  # @param selector [Hash] The selector for the new h2s.
  def self.h2s(element_name, selector)
    define_method element_name.to_s do
      $browser.h2s(selector)
    end
  end

  # For each h3() defined in the page object these methods are added:
  # * <name> - Returns the first matching h3
  # @param element_name [String] The desired name for the new h3.
  # @param selector [Hash] The selector for the new h3.
  def self.h3(element_name, selector)
    define_method element_name.to_s do
      $browser.h3(selector)
    end
  end

  # For each h3s() defined in the page object these methods are added:
  # * <name> - Returns an array of matching h3s
  # @param element_name [String] The desired name for the new h3s.
  # @param selector [Hash] The selector for the new h3s.
  def self.h3s(element_name, selector)
    define_method element_name.to_s do
      $browser.h3s(selector)
    end
  end

  # For each h4() defined in the page object these methods are added:
  # * <name> - Returns the first matching h4
  # @param element_name [String] The desired name for the new h4.
  # @param selector [Hash] The selector for the new h4.
  def self.h4(element_name, selector)
    define_method element_name.to_s do
      $browser.h4(selector)
    end
  end

  # For each h4s() defined in the page object these methods are added:
  # * <name> - Returns an array of matching h4s
  # @param element_name [String] The desired name for the new h4s.
  # @param selector [Hash] The selector for the new h4s.
  def self.h4s(element_name, selector)
    define_method element_name.to_s do
      $browser.h4s(selector)
    end
  end

  # For each h5() defined in the page object these methods are added:
  # * <name> - Returns the first matching h5
  # @param element_name [String] The desired name for the new h5.
  # @param selector [Hash] The selector for the new h5.
  def self.h5(element_name, selector)
    define_method element_name.to_s do
      $browser.h5(selector)
    end
  end

  # For each h5s() defined in the page object these methods are added:
  # * <name> - Returns an array of matching h5s
  # @param element_name [String] The desired name for the new h5s.
  # @param selector [Hash] The selector for the new h5s.
  def self.h5s(element_name, selector)
    define_method element_name.to_s do
      $browser.h5s(selector)
    end
  end

  # For each h7() defined in the page object these methods are added:
  # * <name> - Returns the first matching h7
  # @param element_name [String] The desired name for the new h7.
  # @param selector [Hash] The selector for the new h7.
  def self.h7(element_name, selector)
    define_method element_name.to_s do
      $browser.h7(selector)
    end
  end

  # For each h7s() defined in the page object these methods are added:
  # * <name> - Returns an array of matching h7s
  # @param element_name [String] The desired name for the new h7s.
  # @param selector [Hash] The selector for the new h7s.
  def self.h7s(element_name, selector)
    define_method element_name.to_s do
      $browser.h7s(selector)
    end
  end

  # For each h7() defined in the page object these methods are added:
  # * <name> - Returns the first matching h7
  # @param element_name [String] The desired name for the new h7.
  # @param selector [Hash] The selector for the new h7.
  def self.h7(element_name, selector)
    define_method element_name.to_s do
      $browser.h7(selector)
    end
  end

  # For each h7s() defined in the page object these methods are added:
  # * <name> - Returns an array of matching h7s
  # @param element_name [String] The desired name for the new h7s.
  # @param selector [Hash] The selector for the new h7s.
  def self.h7s(element_name, selector)
    define_method element_name.to_s do
      $browser.h7s(selector)
    end
  end

  # For each div() defined in the page object these methods are added:
  # * <name> - Returns the first matching div
  # @param element_name [String] The desired name for the new div.
  # @param selector [Hash] The selector for the new div.
  def self.div(element_name, selector)
    define_method element_name.to_s do
      $browser.div(selector)
    end
  end

  # For each divs() defined in the page object these methods are added:
  # * <name> - Returns an array of matching divs
  # @param element_name [String] The desired name for the new divs.
  # @param selector [Hash] The selector for the new divs.
  def self.divs(element_name, selector)
    define_method element_name.to_s do
      $browser.divs(selector)
    end
  end

  # For each ul() defined in the page object these methods are added:
  # * <name> - Returns the first matching ul
  # @param element_name [String] The desired name for the new ul.
  # @param selector [Hash] The selector for the new ul.
  def self.ul(element_name, selector)
    define_method element_name.to_s do
      $browser.ul(selector)
    end
  end

  # For each uls() defined in the page object these methods are added:
  # * <name> - Returns an array of matching uls
  # @param element_name [String] The desired name for the new uls.
  # @param selector [Hash] The selector for the new uls.
  def self.uls(element_name, selector)
    define_method element_name.to_s do
      $browser.uls(selector)
    end
  end

  # For each li() defined in the page object these methods are added:
  # * <name> - Returns the first matching li
  # @param element_name [String] The desired name for the new li.
  # @param selector [Hash] The selector for the new li.
  def self.li(element_name, selector)
    define_method element_name.to_s do
      $browser.li(selector)
    end
  end

  # For each lis() defined in the page object these methods are added:
  # * <name> - Returns an array of matching lis
  # @param element_name [String] The desired name for the new lis.
  # @param selector [Hash] The selector for the new lis.
  def self.lis(element_name, selector)
    define_method element_name.to_s do
      $browser.lis(selector)
    end
  end

  # For each ul() defined in the page object these methods are added:
  # * <name> - Returns the first matching ul
  # @param element_name [String] The desired name for the new ul.
  # @param selector [Hash] The selector for the new ul.
  def self.ul(element_name, selector)
    define_method element_name.to_s do
      $browser.ul(selector)
    end
  end

  # For each uls() defined in the page object these methods are added:
  # * <name> - Returns an array of matching uls
  # @param element_name [String] The desired name for the new uls.
  # @param selector [Hash] The selector for the new uls.
  def self.uls(element_name, selector)
    define_method element_name.to_s do
      $browser.uls(selector)
    end
  end

  # For each dropdown() defined in the page object these methods are added:
  # * <name> - Returns the first matching dropdown
  # @param element_name [String] The desired name for the new dropdown.
  # @param selector [Hash] The selector for the new dropdown.
  def self.dropdown(element_name, selector)
    define_method element_name.to_s do
      $browser.select(selector)
    end
  end

  # For each dropdowns() defined in the page object these methods are added:
  # * <name> - Returns an array of matching dropdowns
  # @param element_name [String] The desired name for the new dropdowns.
  # @param selector [Hash] The selector for the new dropdowns.
  def self.dropdowns(element_name, selector)
    define_method element_name.to_s do
      $browser.selects(selector)
    end
  end

  # For each span() defined in the page object these methods are added:
  # * <name> - Returns the first matching span
  # @param element_name [String] The desired name for the new span.
  # @param selector [Hash] The selector for the new span.
  def self.span(element_name, selector)
    define_method element_name.to_s do
      $browser.span(selector)
    end
  end

  # For each spans() defined in the page object these methods are added:
  # * <name> - Returns an array of matching spans
  # @param element_name [String] The desired name for the new spans.
  # @param selector [Hash] The selector for the new spans.
  def self.spans(element_name, selector)
    define_method element_name.to_s do
      $browser.spans(selector)
    end
  end

  ################################ END DYNAMIC METHOD CREATION FOR BASE WATIR ELEMENTS ################################



end

