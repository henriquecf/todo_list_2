require 'rails_helper'

RSpec.describe List, :type => :model do
  describe "should validate" do
    it "presence of name" do
      expect {List.create!}.to raise_error(/Name can't be blank/)
    end

    it "presence of user" do
      expect {List.create!}.to raise_error(/User can't be blank/)
    end
  end

  describe "nested tasks" do
    before :each do
      @user = User.create!(email: 'test@example.com', password: 'test1234')
      @task = Task.new(task_name: 'task')
      @list = List.create!(name: 'list', user: @user, tasks: [@task])
    end

    it "should allow creation of tasks within a list" do
      expect(@list.reload.tasks.size).to eq(1)
    end

    it "should destroy tasks when their lists are destroyed" do
      expect(Task.exists?(@task)).to be_truthy
      @list.destroy
      expect(Task.exists?(@task)).to be_falsey
    end
  end

  describe "favorites" do
    it "should destroy favorites when their lists are destroyed" do
      user = User.create!(email: 'email@example.com', password: 'test1234')
      list = List.create!(name: 'list', user: user)
      favorite = list.favorites.create!(user: user)
      expect(Favorite.exists?(favorite)).to be_truthy
      list.destroy
      expect(Favorite.exists?(favorite)).to be_falsey
    end
  end
end
