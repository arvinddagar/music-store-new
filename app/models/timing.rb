class Timing < ActiveRecord::Base
   belongs_to :day
   has_many :reservations
   # validates :start_time, :presence => true
   # validates :end_time, :presence => true
   before_save :temp

    protected
      def temp
        if self.start_time?
          total=self.day.schedule.lesson.duration
          self.end_time=self.start_time + total*60
        end
      end
end