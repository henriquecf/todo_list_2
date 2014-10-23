Given(/^a user with email "(.*?)" and password "(.*?)"$/) do |email, password|
  @user = User.create!(email: email, password: password, password_confirmation: password)
end

Given(/^I am in sign in page$/) do
  visit '/accounts/sign_in'
end

Then(/^I should be logged in$/) do
  expect(page).to have_content('Signed in successfully.')
end
