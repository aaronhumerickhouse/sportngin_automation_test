#Base component for common functions
class DefaultComponent
  def initialize(selector)
    @selector = selector
  end

  #@return [Boolean] Is the component exist and visible?
  def present?
    base_element.exist? && base_element.visible?
  end

  #@return [Boolean] Is the component visible?
  def visible?
    base_element.visible?
  end

  #@return [Boolean] Does the component exist?
  def exist?
    base_element.exist?
  end

  private
  #@return [Element] The base element for relative elements
  def base_element
    $browser.element(@selector)
  end
end
