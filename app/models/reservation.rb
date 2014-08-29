class Reservation < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :lesson
  belongs_to :student
  belongs_to :timing
  has_one :earning, :dependent => :destroy
  
end
