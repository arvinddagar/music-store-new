class Lesson < ActiveRecord::Base
  belongs_to :tutor
  belongs_to :category
  has_many :pictures, :dependent => :destroy
  accepts_nested_attributes_for :pictures,:allow_destroy => true
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

  has_many :ratings
  has_many :students, through: :ratings


  # delegate :image, to: :picture, allow_nil: true
  acts_as_commentable
  geocoded_by :address
    after_validation :geocode
  searchkick
  SEARCH_FIELDS=[
    :name,:address,:description
  ]
end
