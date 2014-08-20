class Category < ActiveRecord::Base
  has_many :childrens, class_name: 'Category',
                       foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Category'
  has_many :lessons
  validates :category_name, presence: true, uniqueness: { scope: :parent_id, message: 'category already exists.' }
  scope :main_categories, -> { where('parent_id IS NULL') }
  scope :sub_categories, -> { where('parent_id IS NOT NULL') }

  def to_s
    category_name
  end

  def to_param
    "#{id}-#{to_s.parameterize}"
  end
end
