class Category
  include Mongoid::Document
  field :name, type: String
  has_many :activity_categories
  belongs_to :user
end
