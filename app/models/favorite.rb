class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :list

  def mark
    self.marked = self.marked ? false : true
    self.save
  end
end
