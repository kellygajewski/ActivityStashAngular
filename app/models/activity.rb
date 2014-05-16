class Activity
  include Mongoid::Document
  field :name, type: String
  field :location, type: String
  field :link, type: String
  field :notes, type: String
end
