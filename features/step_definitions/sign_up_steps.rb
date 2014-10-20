Given(/^I visit sign_up$/) do
  visit '/accounts/sign_up'
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in field, with: value
end

When(/^I click "(.*?)"$/) do |link_or_button|
  click_on link_or_button
end

Then(/^there should exist a user with email "(.*?)"$/) do |email|
  expect(User.find_by(email: email)).to_not be_nil
end
