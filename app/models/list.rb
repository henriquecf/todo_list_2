class List < ActiveRecord::Base
  validates :name, :user, presence: true
  belongs_to :user
  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks, :reject_if => :all_blank, :allow_destroy => true
end
