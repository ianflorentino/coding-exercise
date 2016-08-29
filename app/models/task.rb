class Task < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true

  has_many :user_tasks
  has_many :users, through: :user_tasks
end
