require 'spec_helper'

describe 'cucumber priority', :type => :aruba do

  before do
    create_empty_cucumber_project
  end

  it 'allows to define overridable steps' do
    add_step_definitions <<-RUBY
      Given(/^there is a movie with a (.*?) tone$/) { puts 'ran overridable step' }.overridable
      Given(/^there is a movie with a funny tone$/) { puts 'ran overriding step' }
    RUBY
    run_scenario <<-GHERKIN
      Scenario: Call overriden step
        Given there is a movie with a funny tone
    GHERKIN
    expect(all_stdout).not_to include('ran overridable step')
    expect(all_stdout).to include('ran overriding step')
  end

  it 'raises Cucumber::Ambiguous if more than two overriding steps match' do
    add_step_definitions <<-RUBY
      Given(/^there is a movie with (.*?) tone$/){}.overridable(:priority => 1000)
      Given(/^there is a movie with a [^ ]+ tone$/){}
      Given(/^there is a movie with a funny tone$/){}
    RUBY
    run_scenario <<-GHERKIN, :fail_on_error => false
      Scenario: Try to call ambiguous steps
        Given there is a movie with a funny tone
    GHERKIN
    expect(all_output).to include('Ambiguous match of "there is a movie with a funny tone"')
  end

  it 'runs the step with the highest priority if multiple overridable steps match' do
    add_step_definitions <<-RUBY
      Given(/^there is a movie with a (.*?) tone$/){ puts 'ran default priority step' }.overridable
      Given(/^there is a movie with a [^ ]+ tone$/){ puts 'ran high priority step' }.overridable(:priority => 5)
      Given(/^there is a movie with a [^ ]+ tone$/){ puts 'ran low priority step' }.overridable(:priority => -5)
    RUBY
    run_scenario <<-GHERKIN
      Scenario: Try to call ambiguous steps
        Given there is a movie with a funny tone
    GHERKIN
    expect(all_stdout).to include('ran high priority step')
  end

end
