class Activity
  include Mongoid::Document
  field :name, type: String
  field :location, type: String
  field :link, type: String
  field :notes, type: String
  field :latitude, type: String
  field :longitude, type: String
  field :coordinates, type: Array

  include Geocoder::Model::Mongoid
	geocoded_by :address               # can also be an IP address
	after_validation :geocode 
end
