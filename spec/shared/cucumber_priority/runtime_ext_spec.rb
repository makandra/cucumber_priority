require 'spec_helper'

require_relative 'cucumber_helper'

describe Cucumber::Runtime, 'extended with cucumber_priority' do

  before(:each) do
    prepare_cucumber_example
  end

  describe '#step_match' do

    it 'returns an overriding step if the only other match is a overridable step' do
      overridable_step = @main.Given(/^there is a movie with a (.*?) tone/){ }.overridable
      overriding_step = @main.Given(/^there is a movie with a funny tone/){ }
      match = @runtime.step_match('there is a movie with a funny tone')
      match.step_definition.should == overriding_step
      match.should be_a(Cucumber::StepMatch)
    end

    it 'raises Cucumber::Ambiguous if more than two overriding steps match' do
      @main.Given(/^there is a movie with (.*?) tone/){}.overridable(:priority => 1000)
      @main.Given(/^there is a movie with a [^ ]+ tone/){}
      @main.Given(/^there is a movie with a funny tone/){}
      expect do
        @runtime.step_match('there is a movie with a funny tone')
      end.to raise_error(Cucumber::Ambiguous)
    end

    it 'returns the overridable step with the highest priority if no overriding steps match' do
      overridable_step = @main.Given(/^there is a movie with a (.*?) tone/){ }.overridable
      higher_overridable_step = @main.Given(/^there is a movie with a [^ ]+ tone/){ }.overridable(:priority => 5)
      lower_overridable_step = @main.Given(/^there is a movie with a [^ ]+ tone/){ }.overridable(:priority => -5)
      match = @runtime.step_match('there is a movie with a funny tone')
      match.step_definition.should == higher_overridable_step
      match.should be_a(Cucumber::StepMatch)
    end
    
  end

end
