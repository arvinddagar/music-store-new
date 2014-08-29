class Earning < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :tutor
end