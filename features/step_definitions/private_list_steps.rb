Given(/^I create a private list$/) do
  @list = List.create!(name: "Private list", is_private: true, user_id: @user.id)
end

Given(/^I log out$/) do
  visit '/accounts/sign_out'
end

When(/^I visit "(.*?)"$/) do |path|
  visit path
end

When(/^I log in as another user$/) do
  email = "another@example.com"
  password = "another123"
  @another_user = User.create!(email: email, password: password, password_confirmation: password)
  visit '/accounts/sign_in'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_on 'Log in'
end

When(/^I go to his private list$/) do
  visit "/lists/#{@list.id}"
end

When(/^I visit the users lists path$/) do
  visit "/users/#{@user.id}/lists"
end

Then(/^I should see "(.*?)"$/) do |message|
  expect(page).to have_content(message)
end

Then(/^I should not see "(.*?)"$/) do |message|
  expect(page).not_to have_content(message)
end

Then(/^I should be in my lists path$/) do 
  expect(page.current_path).to eq("/users/#{@another_user.id}/lists")
end
