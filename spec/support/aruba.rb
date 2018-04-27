require 'aruba/api'
require 'aruba/in_process'
require 'cucumber/cli/main'

Aruba.process = Aruba::InProcess
Aruba::InProcess.main_class = Cucumber::Cli::Main

Gemika::RSpec.configure do |config|
  config.include Aruba::Api

  config.before(:each) do
    restore_env
    clean_current_dir
  end
end
