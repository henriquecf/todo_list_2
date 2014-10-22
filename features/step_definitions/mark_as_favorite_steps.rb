Given(/^I am in the path of a public list from another user$/) do
  user = User.create!(email: "another@example.com", password: "test1234")
  @list = List.create!(name: "My list", is_private: false, user: user)
  visit "/lists/#{@list.id}"
end

Then(/^the list should be in my favorites list$/) do
  expect(@user.favorites).to include(@list)
end
