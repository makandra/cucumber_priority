Given /^there is a movie with a (.*?) tone$/ do
  puts "First step"
end.overridable(priority: 1)

Given /^there is a movie with a funny tone$/ do
  puts "Second step"
end.overridable(priority: 2)
