cucumber_priority [![Tests](https://github.com/makandra/cucumber_priority/workflows/Tests/badge.svg)](https://github.com/makandra/cucumber_priority/actions?query=branch:master)
=================

Overridable step definitions for Cucumber
-----------------------------------------

[Cucumber](https://github.com/cucumber/cucumber-ruby) raises an error if more than one step definitions match a step.

This gem provides a way to mark step definitions as *overridable*, meaning that they can always be overshadowed by a more specific version without raising an error.


Examples
--------

### Marking step definitions as overridable

To mark a step definition as overridable, call `#overridable` on the definition object:

```ruby
Given /^there is a movie with a (.*?) tone$/ do
  ...
end.overridable

Given /^there is a movie with a funny tone$/ do
  ...
end
```

The following step will now **no longer raise `Cucumber::Ambiguous`**:

```cucumber
Given there is a movie with a funny tone
```

If a step matches more than one non-overridable steps, Cucumber will still raise `Cucumber::Ambiguous`.


### Defining priorities

You can define priorities for overridable steps by passing an numeric `:priority` option to `#overridable:`

```ruby
Given /^there is a movie with a (.*?) tone$/ do
  ...
end.overridable(priority: 1)

Given /^there is a movie with a (sad|upbeat|disturbing) tone$/ do
  ...
end.overridable(priority: 5)
```

A higher priority wins the match.

A non-overridable step will always win over an overridable step regardless of its priority.


Supported Cucumber versions
----------------------------

cucumber_priority is tested against Cucumber 1.3, 2.4, 3.0 and 3.1.


Installation
------------

In your `Gemfile` say:

```ruby
gem 'cucumber_priority'
```

Now run `bundle install` and restart your server.


Development
-----------

There are tests in `spec`. We only accept PRs with tests. To run tests:

- Install Ruby 2.5.3
- Install development dependencies using `bundle install`
- Run tests using `bundle exec rspec`

We recommend to test large changes against multiple versions of Ruby and multiple dependency sets. Supported combinations are configured in `.github/workflows/test.yml`. We provide some rake tasks to help with this:

- Install development dependencies using `bundle matrix:install`
- Run tests using `bundle matrix:spec`

Note that we have configured GitHub Actions to automatically run tests in all supported Ruby versions and dependency sets after each push. We will only merge pull requests after a green workflow build.

If you would like to contribute:

- Fork the repository.
- Push your changes **with passing specs**.
- Send us a pull request.

I'm very eager to keep this gem leightweight and on topic. If you're unsure whether a change would make it into the gem  [talk to me beforehand](mailto:henning.koch@makandra.de).


Credits
-------

Henning Koch from [makandra](https://makandra.com/)

