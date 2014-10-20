require 'rails_helper'

RSpec.describe "lists/show", :type => :view do
  before(:each) do
    @list = assign(:list, List.create!(name: "Test", user: User.create!(email: 'test@example.com', password: 'test1234')))
  end

  it "renders attributes in <p>" do
    render
  end
end
