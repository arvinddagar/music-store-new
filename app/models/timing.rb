class Timing < ActiveRecord::Base
   belongs_to :day
   has_many :reservations
end
