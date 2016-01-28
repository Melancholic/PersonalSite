class Article < ActiveRecord::Base
    belongs_to :category
    belongs_to :author, class_name: User, foreign_key: :user_id
    validates :category,  presence: true
    validates :author,  presence: true
end
