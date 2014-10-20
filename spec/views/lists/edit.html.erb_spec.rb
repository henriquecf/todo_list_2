require 'rails_helper'

RSpec.describe "lists/edit", :type => :view do
  before(:each) do
    @list = assign(:list, List.create!(name: "test", user: User.create!(email: 'test@example.com', password: 'test1234')))
  end

  it "renders the edit list form" do
    render

    assert_select "form[action=?][method=?]", list_path(@list), "post" do
    end
  end
end
