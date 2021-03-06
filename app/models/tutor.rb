class Tutor < ActiveRecord::Base
    belongs_to :user
    accepts_nested_attributes_for :user
    has_many :lessons, dependent: :destroy
        validates :first_name, presence: true, :on => :create
    validates :last_name, presence: true, :on => :create
    validates :description, presence: true, :on => :update
    validates :about_me, presence: true, :on => :update
    validates :duration, presence: true, :on => :update
    validates :skills, presence: true, :on => :update
    validates :teaching_philosophy, presence: true, :on => :update
    validates :cre, presence: true, :on => :update
    validates :age_group, presence: true, :on => :update
    validates :instruments, presence: true, :on => :update
    validates :experience, presence: true, :on => :update
    has_attached_file :image
    has_many :earnings, :dependent => :destroy
    
    has_many :favorites
    has_many :students, through: :favorites

    validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
    geocoded_by :address
    after_validation :geocode
    delegate :email, to: :user, allow_nil: true
  COMPLETE_ATTRIBUTES = [
    :description, :about_me, :duration, :skills , :teaching_philosophy , :cre , :age_group , :instruments ,:experience
  ]

  def complete?
    COMPLETE_ATTRIBUTES.all? { |attr| send(attr).present? }
  end

  def incomplete?
    !complete?
  end
end