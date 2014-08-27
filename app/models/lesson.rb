class Lesson < ActiveRecord::Base
  belongs_to :tutor
  has_many :payments
  belongs_to :category
  has_many :pictures
  has_one :schedule, :dependent => :destroy
  has_one :schedule
  has_many :reservations
  validates :name, :presence => true
  validates :description, :presence => true
  validates :neighbourhood, :presence => true
  validates :address, :presence => true
  validates :phone_no, :presence => true
  validates :price, :presence => true
  validates :duration, :presence => true
  validates :maximum_people, :presence => true
  acts_as_commentable
  geocoded_by :address
    after_validation :geocode
  searchkick
  SEARCH_FIELDS=[
    :name,:address,:description
  ]
end
