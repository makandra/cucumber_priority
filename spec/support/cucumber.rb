module CucumberHelper
  @counter = 0
  class << self
    attr_accessor :counter
  end

  def create_empty_cucumber_project
    in_current_directory do
      FileUtils.cp_r(File.expand_path(File.join(__FILE__, '..', '..', 'fixtures', 'features')), 'features')
    end
  end

  def add_step_definitions(content)
    count = CucumberHelper.counter += 1
    write_file("features/step_definitions/#{count}.rb", content)
  end

  def run_scenario(content, options = {})
    feature_path = 'features/test.feature'
    write_file(feature_path, <<-GHERKIN)
Feature: Cucumber priority test

#{content}
    GHERKIN
    run_command_and_stop("cucumber #{feature_path}", options.slice(:fail_on_error))
  end
end

Gemika::RSpec.configure do |config|
  config.include CucumberHelper
end
