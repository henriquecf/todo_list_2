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

Then(/^I list named "(.*?)" should have been created$/) do |name|
  expect(List.where(name: name)).not_to be_empty
end
