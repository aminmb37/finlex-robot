class Robot < ApplicationRecord
  has_many :commands
  validates :name, presence: true
  validates :x, presence: true
  validates :y, presence: true
  validates :direction, presence: true
end
