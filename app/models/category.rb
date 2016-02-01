class Category < ActiveRecord::Base
  belongs_to :parent, class_name:"Category", foreign_key:"parent_id"
  has_many :childrens,  class_name:"Category", foreign_key:"parent_id"
  has_many :articles
  scope :rooted, -> {where(parent:nil)}
  scope :sub_categories, -> (prnt) {where(parent:prnt)}
  validates(:title, presence: true, length: {minimum: 5, maximum:30},uniqueness: {case_sensitive: false});
  validates(:description, presence: false, length: {maximum:100});
  validates(:weight, presence: false, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to:100 });
  
  before_create do
    self.weight=50;
  end
end
