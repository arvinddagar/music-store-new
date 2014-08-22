class Timing < ActiveRecord::Base
   belongs_to :day
   has_many :reservations
   validates :start_time, :presence => true
   validates :end_time, :presence => true
end
