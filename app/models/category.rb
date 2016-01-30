class Category < ActiveRecord::Base
  belongs_to :parrent, class_name:"Category", foreign_key:"parrent_id"
  has_many :childrens,  class_name:"Category", foreign_key:"parrent_id"
  has_many :articles
  scope :rooted, -> {where(parrent:nil)}
  scope :sub_categories, -> (prnt) {where(parrent:prnt)}
end
