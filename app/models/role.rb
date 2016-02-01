class Role < ActiveRecord::Base
    has_and_belongs_to_many :users
    validates_uniqueness_of :name
    validates(:name, presence: true, length: {minimum: 3, maximum:15});
end
