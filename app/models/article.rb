class Article < ActiveRecord::Base
    belongs_to :category
    belongs_to :author, class_name: User, foreign_key: :user_id
    validates :category,  presence: true
    validates :author,  presence: true
    validates(:title, presence: true, length: {minimum: 10, maximum:100});
    validates(:body, presence: true, length: {minimum: 50, maximum:10000});
    scope :by_category, -> (cat) {where(category:cat)}
end
