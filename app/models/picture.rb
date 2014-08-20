class Picture < ActiveRecord::Base
  has_attached_file :image
  belongs_to :lesson
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
