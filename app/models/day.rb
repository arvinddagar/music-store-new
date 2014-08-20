class Day < ActiveRecord::Base
  belongs_to :schedule
  has_many :timings, dependent: :destroy
  accepts_nested_attributes_for :timings
end
