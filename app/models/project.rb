class Project < ApplicationRecord
  belongs_to :paper
  has_many :tasks
end
