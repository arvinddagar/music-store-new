class Student < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user
  has_attached_file :image
  has_many :reservations
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  delegate :email, to: :user, allow_nil: true
   COMPLETE_ATTRIBUTES = [
    :address]
    def complete?
    COMPLETE_ATTRIBUTES.all? { |attr| send(attr).present? }
  end

  has_many :favorites
  has_many :tutors, through: :favorites


   has_many :ratings
    has_many :lessons, through: :ratings

  def incomplete?
    !complete?
  end
end