require_relative 'default_component'
require_relative '../pages/boards_page'

#Component for the Board well
class BoardComponent < DefaultComponent
  #@return [Element] The base element to interact with the entire board component
  def element
    base_element
  end

  #@return [String] The title of the board
  def title
    title_element.when_present.text
  end

  #Navigates into the board
  def navigate_into
    title_element.when_present.click
  end

  #@return [String] The description of the board
  def description
    base_element.div(css: 'div.description').text
  end

  #Deletes the board
  def delete
    base_element.link(css: 'a.delete').click
    boards_page = BoardsPage.new $browser
    boards_page.delete_board.when_present.click
  end

  #Edits the board
  #@param [Hash] data
  #@option data [String] title The new title
  #@option data [String] description The new description
  def edit(data)
    base_element.link(css: 'a[data-target="#edit_board_modal"]').click
    boards_page = BoardsPage.new $browser
    boards_page.edit_board_title.when_present.set data[:title] if data[:title]
    boards_page.edit_board_description.when_present.set data[:description] if data[:description]
    boards_page.save_edit_board.click
  end

  private
  #@return [Link] The link element that represents the title
  def title_element
    base_element.link(css: 'a.alignleft')
  end
end
