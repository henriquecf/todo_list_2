require 'rails_helper'

RSpec.describe "lists/show", :type => :view do
  before(:each) do
    @list = assign(:list, List.create!(name: "Test", user: User.create!(email: 'test@example.com', password: 'test1234')))
  end

  it "renders list name" do
    render
    expect(rendered).to include('Test')
  end

  it "renders tasks" do
    @list.tasks.create!(task_name: 'task')
    render
    expect(rendered).to include('task')
  end
end
