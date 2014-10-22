require 'rails_helper'

RSpec.describe Favorite, :type => :model do
  describe ".mark" do
    it "should mark a new association" do
      favorite = Favorite.create!
      favorite.mark
      expect(favorite.marked).to be_truthy
    end

    it "should unmark a association that is marked" do
      favorite = Favorite.create!
      favorite.marked = true
      favorite.mark
      expect(favorite.marked).to be_falsey
    end

    it "should mark a association that is unmarked" do
      favorite = Favorite.create!
      favorite.marked = false
      favorite.mark
      expect(favorite.marked).to be_truthy
    end
  end
end
