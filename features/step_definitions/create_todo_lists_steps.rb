Given(/^I am a logged in user$/) do
  email = "elo.henrique@gmail.com"
  password = "hc031190"
  @user = User.create!(email: email, password: password, password_confirmation: password)
  visit '/accounts/sign_in'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_on 'Log in'
end

Given(/^I am in list creation path$/) do
  visit '/lists/new'
end

When(/^I check "(.*?)"$/) do |option|
  check option
end

Then(/^a list named "(.*?)" should have been created$/) do |name|
  @list = List.where(name: name).first
  expect(@list).not_to be_nil
end

Then(/^that list should have (\d+) tasks assigned to it$/) do |number_of_tasks|
  expect(@list.tasks.size).to eq(number_of_tasks.to_i)
end

Then(/^there should be (\d+) nested fields$/) do |number_of_fields|
  expect(all('.nested-fields').size).to eq(number_of_fields.to_i)
end
