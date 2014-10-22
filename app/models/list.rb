class List < ActiveRecord::Base
  validates :name, :user, presence: true
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks, :reject_if => lambda { |task| task[:task_name].blank? }, :allow_destroy => true
end
