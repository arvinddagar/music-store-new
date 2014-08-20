class Schedule < ActiveRecord::Base
  belongs_to :lesson
  has_many :reservations,dependent: :destroy
  has_many :days,dependent: :destroy
  accepts_nested_attributes_for :days
end
