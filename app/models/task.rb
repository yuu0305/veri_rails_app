# app/models/task.rb
class Task < ApplicationRecord
  validates :title, presence: true
  validates :status, inclusion: { in: %w[pending in_progress completed] }
  validates :priority, numericality: { only_integer: true, greater_than: 0, less_than: 6 }

  scope :by_priority, -> { order(priority: :asc) }
end
