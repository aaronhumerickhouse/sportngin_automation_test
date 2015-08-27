require_relative 'default_page'
require_relative '../components/board_component'

#Page Object for the Boards Page
class BoardsPage < DefaultPage
  page_url "#{DefaultHelper.get_root_url}boards"
  title 'Kalmban | Boards'
  expected_element('a', {href: '/boards/new'}, 10)

  # For each board() defined in the page object these methods are added:
  # * <name> - Returns the board
  # @param element_name [String] The desired name for the new board.
  # @param selector [Hash] The selector of the select element the selector is designed around.
  def self.board(element_name, selector)
    define_method element_name.to_s do
      BoardComponent.new(selector)
    end
  end

  # For each boards() defined in the page object these methods are added:
  # * <name> - Returns the boards
  # @param element_name [String] The desired name for the new boards.
  # @param selector [Hash] The selector of the boards.  Must be xpath or css selector
  def self.boards(element_name, selector)
    define_method element_name.to_s do
      found_elements = $browser.elements(selector)
      (0..found_elements.size - 1).collect do |index|
        BoardComponent.new(
            selector[:xpath] ? {xpath: selector[:xpath], index: index} : {css: selector[:css], index: index}
        )
      end
    end
  end

  boards(:boards, css: 'li.board')
  link(:new_board, href: '/boards/new')

  text_field(:new_board_title, css: 'div#new_board_modal #board_title')
  text_area(:new_board_description, css: 'div#new_board_modal #board_description')
  button(:close_new_board_modal, css: 'div#new_board_modal div.modal-footer button.btn.btn-default')
  input(:save_new_board, css: 'div#new_board_modal div.modal-footer input.btn.btn-primary')

  text_field(:edit_board_title, css: 'div#edit_board_modal #board_title')
  text_area(:edit_board_description, css: 'div#edit_board_modal #board_description')
  button(:close_edit_board_modal, css: 'div#edit_board_modal div.modal-footer button.btn.btn-default')
  input(:save_edit_board, css: 'div#edit_board_modal div.modal-footer input.btn.btn-primary')

  button(:close_delete_board_modal, css: 'div#delete_board_modal div.modal-footer button.btn.btn-default')
  input(:delete_board, css: 'div#delete_board_modal div.modal-footer input.btn.btn-primary')

  #Moves a board well to a specific index
  #@param from_index [Integer] The board well to use
  #@param to_index [Integer] The board well to move to
  def move_board(from_index, to_index)
    initial = boards[from_index].element
    target = boards[to_index].element

    initial_x = initial.wd.location['x']
    initial_y = initial.wd.location['y']

    target_x = target.wd.location['x']
    target_y = target.wd.location['y']

    total_x = target_x - initial_x + 5
    total_y = target_y - initial_y + 5

    initial.drag_and_drop_by(total_x, total_y)
  end

  #Creates a new board with a title and description
  #@title [String] Title of the task
  #@description [String] Description of the task
  def create_new_board(title, description)
    new_board.click
    new_board_title.when_present.set title
    new_board_description.set description
    save_new_board.click
  end
end
