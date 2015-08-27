require_relative 'default_component'
require_relative '../pages/tasks_page'

#Component for the Task well
class TaskComponent < DefaultComponent
  #@return [Element] The base element to interact with the entire task component
  def element
    base_element
  end

  #@return [String] The title of the task
  def title
    title_element.when_present.text
  end

  #Navigates into the task
  def navigate_into
    title_element.when_present.click
  end

  #@return [String] The description of the task
  def description
    base_element.div(css: 'div.description').text.split('Description: ')[1]
  end

  #Deletes the task
  def delete
    base_element.link(css: 'a.delete').click
    tasks_page = TasksPage.new $browser
    tasks_page.delete_task.when_present.click
  end

  #Edits the task
  #@param [Hash] data
  #@option data [String] title The new title
  #@option data [String] description The new description
  def edit(data)
    base_element.link(css: 'a[data-target="#edit_task_modal"]').click
    tasks_page = TasksPage.new $browser
    tasks_page.edit_task_title.when_present.set data[:title] if data[:title]
    tasks_page.edit_task_description.when_present.set data[:description] if data[:description]
    tasks_page.edit_task_status.when_present.select data[:status] if data[:status]
    tasks_page.save_edit_task.click
  end

  private
  #@return [Link] The link element that represents the title
  def title_element
    base_element.link(css: 'div.task a.show')
  end
end
