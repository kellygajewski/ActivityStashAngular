class ActivityCategory
  include Mongoid::Document
  belongs_to :category
  belongs_to :activity
end
