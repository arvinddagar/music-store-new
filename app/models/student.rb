class Student < ActiveRecord::Base
  belongs_to :user
  accepts_nested_attributes_for :user
  has_attached_file :image
  has_many :reservations
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

   COMPLETE_ATTRIBUTES = [
    :address]
    def complete?
    COMPLETE_ATTRIBUTES.all? { |attr| send(attr).present? }
  end

  def incomplete?
    !complete?
  end
end