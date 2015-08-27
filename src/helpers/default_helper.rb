require 'yaml'

#The Default Helper
class DefaultHelper

  #@return [String] The root url
  def self.get_root_url
    return YAML.load(File.new(File.expand_path('../../resources/config.yml', File.dirname(__FILE__))))['base_url']
  end

  #@return [String] The username
  def self.get_username
    return YAML.load(File.new(File.expand_path('../../resources/config.yml', File.dirname(__FILE__))))['username']
  end

  #@return [String] The password
  def self.get_password
    return YAML.load(File.new(File.expand_path('../../resources/config.yml', File.dirname(__FILE__))))['password']
  end
end
