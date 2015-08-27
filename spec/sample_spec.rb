require_relative '../src/pages/landing_page'
require_relative '../src/pages/boards_page'
require_relative 'spec_helper'

describe 'Sample Spec' do
  it 'can login' do
    landing_page = LandingPage.new $browser
    landing_page.sign_in_with_google(DefaultHelper.get_username, DefaultHelper.get_password)
  end

  it 'can open modals' do
    boards_page = BoardsPage.new $browser
    boards_page.open_about_modal
    expect(boards_page.about_modal.wait_until_present).to be_truthy
    boards_page.close_about_modal.when_present.click
    expect($browser.wait_until(3) {!boards_page.about_modal.present?}).to be_truthy
  end

  it 'can view boards' do
    boards_page = BoardsPage.new $browser
    expect(boards_page.boards.size).not_to eq 0
  end

  it 'can arrange boards' do
    boards_page = BoardsPage.new $browser
    array = boards_page.boards.collect { |board| board.title }
    boards_page.move_board(0,1)
    array.insert(1, array.delete_at(0))
    expect(boards_page.boards.collect { |board| board.title }).to eq(array)
  end

  it 'can create boards' do
    boards_page = BoardsPage.new $browser
    initial_board_size = boards_page.boards.size
    title = "title#{rand(1000)}"
    description = 'Here is the default description.'
    boards_page.create_new_board(title, description)
    final_boards_size = boards_page.boards.size
    expect(final_boards_size).to eq(initial_board_size + 1)
    expect(boards_page.boards[-1].title).to eq title
    expect(boards_page.boards[-1].description).to eq description
  end

  it 'can edit boards' do
    boards_page = BoardsPage.new $browser
    board = boards_page.boards[-1]
    description = 'Here is the new description.'
    board.edit(description: description)
    expect(board.description).to eq description
  end

  it 'can delete boards' do
    boards_page = BoardsPage.new $browser
    boards = boards_page.boards
    initial_board_size = boards.size
    deleted_title = boards[-1].title
    boards[-1].delete
    array = boards_page.boards.collect { |board| board.title }
    expect(array).not_to include deleted_title
    expect(boards_page.boards.size).to eq(initial_board_size - 1)
  end

  it 'can sign out' do
    boards_page = BoardsPage.new $browser
    boards_page.sign_out
    LandingPage.new $browser
    expect($browser.url).to eq DefaultHelper.get_root_url
  end

end
