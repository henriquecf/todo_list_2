Given(/^I am in the path of a public list from another user$/) do
  user = User.create!(email: "another@example.com", password: "test1234")
  @list = List.create!(name: "My list", is_private: false, user: user)
  visit "/lists/#{@list.id}"
end

Given(/^I am in the path of a public list from another user marked as favorite$/) do
  user = User.create!(email: "another@example.com", password: "test1234")
  @list = List.create!(name: "My list", is_private: false, user: user)
  favorite = @list.favorites.find_or_create_by(user: @user)
  favorite.mark
  visit "/lists/#{@list.id}"
end

Then(/^the list should be in my favorites list$/) do
  expect(@list.favorites.find_or_create_by(user: @user).marked).to be_truthy
end

Then(/^the list should not be in my favorites list$/) do
  expect(@list.favorites.find_or_create_by(user: @user).marked).to be_falsey
end

Then(/^I should be in the list path$/) do
  expect(current_path).to eq("/lists/#{@list.id}")
end
