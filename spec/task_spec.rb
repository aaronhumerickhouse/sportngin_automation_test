require_relative '../src/pages/landing_page'
require_relative '../src/pages/tasks_page'
require_relative 'spec_helper'

describe 'Task Spec' do
  before :all do
    landing_page = LandingPage.new $browser
    landing_page.sign_in_with_google(DefaultHelper.get_username, DefaultHelper.get_password)

    boards_page = BoardsPage.new $browser
    boards_page.boards.each_with_index do |board, index|
      @index = index if board.title == 'Example Board'
    end

    boards_page.boards[@index].navigate_into
  end

  #TODO
  it 'can open modals' do
  end

  #TODO
  it 'can view tasks' do
  end

  #TODO
  it 'can arrange tasks within the to_do status' do
  end

  #TODO
  it 'can create to_do tasks' do
  end

  #TODO
  it 'can create in_progress tasks' do
  end

  #TODO
  it 'can create completed tasks' do
  end

  #TODO
  it 'can edit tasks' do
  end

  #TODO
  it 'can delete to_do tasks' do
  end

  #TODO
  it 'can delete in_progress tasks' do
  end

  #TODO
  it 'can delete completed tasks' do
  end

  #TODO
  it 'can sign out' do
  end
end
