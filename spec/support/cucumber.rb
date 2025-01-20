module CucumberHelper
  @counter = 0
  class << self
    attr_accessor :counter
  end

  def create_empty_cucumber_project
    if defined?(Aruba::VERSION) && Gem::Version.new(Aruba::VERSION) >= Gem::Version.new('1.0.0')
      in_current_directory do
        FileUtils.cp_r(File.expand_path(File.join(__FILE__, '..', '..', 'fixtures', 'features')), 'features')
      end
    else
      in_current_dir do
        FileUtils.cp_r(File.expand_path(File.join(__FILE__, '..', '..', 'fixtures', 'features')), 'features')
      end
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
    if defined?(Aruba::VERSION) && Gem::Version.new(Aruba::VERSION) >= Gem::Version.new('1.0.0')
      run_command_and_stop("cucumber #{feature_path}", options.slice(:fail_on_error))
    else
      run_simple("cucumber #{feature_path}", options.fetch(:fail_on_error, true))
    end
  end
end

Gemika::RSpec.configure do |config|
  config.include CucumberHelper
end
