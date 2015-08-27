require_relative 'default_page'
require_relative '../components/task_component'

#Page Object for the Tasks Page
class TasksPage < DefaultPage
  page_url /#{DefaultHelper.get_root_url}boards\/\d*\/tasks/
  title 'Kalmban'
  expected_element('a', {css: 'a[data-target="#new_task_modal"]'}, 10)

  # For each task() defined in the page object these methods are added:
  # * <name> - Returns the task
  # @param element_name [String] The desired name for the new task.
  # @param selector [Hash] The selector of the select element the selector is designed around.
  def self.task(element_name, selector)
    define_method element_name.to_s do
      TaskComponent.new(selector)
    end
  end

  # For each tasks() defined in the page object these methods are added:
  # * <name> - Returns the tasks
  # @param element_name [String] The desired name for the new tasks.
  # @param selector [Hash] The selector of the tasks.  Must be xpath or css selector
  def self.tasks(element_name, selector)
    define_method element_name.to_s do
      found_elements = $browser.elements(selector)
      (0..found_elements.size - 1).collect do |index|
        TaskComponent.new(
            selector[:xpath] ? {xpath: selector[:xpath], index: index} : {css: selector[:css], index: index}
        )
      end
    end
  end

  tasks(:to_do_tasks, css: 'ul#to_do_status li.task')
  tasks(:in_progress_tasks, css: 'ul#in_progress_status li.task')
  tasks(:completed_tasks, css: 'ul#completed_status li.task')
  tasks(:all_tasks, css: 'li.task')


  link(:new_task, css: 'a[data-target="#new_task_modal"]')

  text_field(:new_task_title, css: 'div#new_task_modal #task_title')
  text_area(:new_task_description, css: 'div#new_task_modal #task_description')
  select(:new_task_status, css: 'div#new_task_modal #task_status')
  select(:new_task_due_month, css: 'div#new_task_modal #task_due_date_2i')
  select(:new_task_due_day, css: 'div#new_task_modal #task_due_date_3i')
  select(:new_task_due_year, css: 'div#new_task_modal #task_due_date_1i')
  button(:close_new_task_modal, css: 'div#new_task_modal div.modal-footer button.btn.btn-default')
  input(:save_new_task, css: 'div#new_task_modal div.modal-footer input.btn.btn-primary')

  text_field(:edit_task_title, css: 'div#edit_task_modal #task_title')
  text_area(:edit_task_description, css: 'div#edit_task_modal #task_description')
  select(:edit_task_status, css: 'div#edit_task_modal #task_status')
  select(:edit_task_due_month, css: 'div#edit_task_modal #task_due_date_2i')
  select(:edit_task_due_day, css: 'div#edit_task_modal #task_due_date_3i')
  select(:edit_task_due_year, css: 'div#edit_task_modal #task_due_date_1i')
  select(:edit_task_completed_month, css: 'div#edit_task_modal #task_completed_date_2i')
  select(:edit_task_completed_day, css: 'div#edit_task_modal #task_completed_date_3i')
  select(:edit_task_completed_year, css: 'div#edit_task_modal #task_completed_date_1i')
  button(:close_edit_task_modal, css: 'div#edit_task_modal div.modal-footer button.btn.btn-default')
  input(:save_edit_task, css: 'div#edit_task_modal div.modal-footer input.btn.btn-primary')

  button(:close_delete_task_modal, css: 'div#delete_task_modal div.modal-footer button.btn.btn-default')
  input(:delete_task, css: 'div#delete_task_modal div.modal-footer input.btn.btn-primary')

  #Moves a task well to a specific index within the to_do column
  #@param from_index [Integer] The task well to use
  #@param to_index [Integer] The task well to move to
  def move_task_in_to_do(from_index, to_index)
    initial = to_do_tasks[from_index].element
    target = to_do_tasks[to_index].element

    move_task(initial, target)
  end

  #Moves a task well to a specific index within the in_progress column
  #@param from_index [Integer] The task well to use
  #@param to_index [Integer] The task well to move to
  def move_task_in_in_progress(from_index, to_index)
    initial = in_progress_tasks[from_index].element
    target = in_progress_tasks[to_index].element

    move_task(initial, target)
  end

  #Moves a task well to a specific index within the completed column
  #@param from_index [Integer] The task well to use
  #@param to_index [Integer] The task well to move to
  def move_task_in_completed(from_index, to_index)
    initial = completed_tasks[from_index].element
    target = completed_tasks[to_index].element

    move_task(initial, target)
  end

  #Moves a task well to a specific index within the completed column
  #@param initial [Element] The element to move
  #@param target [Element] The element to move to
  def move_task(initial, target)
    initial_x = initial.wd.location['x']
    initial_y = initial.wd.location['y']

    target_x = target.wd.location['x']
    target_y = target.wd.location['y']

    total_x = target_x - initial_x + 5
    total_y = target_y - initial_y + 5

    initial.when_present.drag_and_drop_by(total_x, total_y)
    sleep 1 #Allow for motion to happen
  end

  #Creates a new task
  #@param data [Hash]
  #@option data [String] title
  #@option data [String] description
  #@option data [String] status. 'To Do, In Progress, Completed'
  def create_new_task(data)
    new_task.click
    new_task_title.when_present.set data[:title] if data[:title]
    new_task_description.set data[:description] if data[:description]
    new_task_status.select data[:status] if data[:status]
    save_new_task.click
  end


end
