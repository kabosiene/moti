class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true
  belongs_to :parent, class_name: 'Task', optional: true
  has_many :children, class_name: 'Task', foreign_key: 'parent_id'
end
