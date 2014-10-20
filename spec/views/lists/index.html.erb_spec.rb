require 'rails_helper'

RSpec.describe "lists/index", :type => :view do
  before(:each) do
    assign(:lists, [
      List.create!(name: "list 1", user: User.create!(email: 'test@example.com', password: 'test1234')),
      List.create!(name: "list 2", user: User.create!(email: 'test2@example.com', password: 'test1234'))
    ])
  end

  it "renders a list of lists" do
    render
  end
end
