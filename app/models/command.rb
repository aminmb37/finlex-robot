class Command < ApplicationRecord
  belongs_to :robot
  validates :cmdtype, presence: true
  validates :xbfr, presence: true
  validates :ybfr, presence: true
  validates :xaftr, presence: true
  validates :yaftr, presence: true
  validates :robot_id, presence: true
end
