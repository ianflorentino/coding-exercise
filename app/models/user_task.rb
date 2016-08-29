class UserTask < ApplicationRecord
  validates :user_id, :uniqueness => {:scope => :task_id}

  belongs_to :user
  belongs_to :task
end
