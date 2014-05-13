class Activity
  include Mongoid::Document
  field :name, type: String
  field :location, type: String
  field :date, type: String
  field :notes, type: String
end
