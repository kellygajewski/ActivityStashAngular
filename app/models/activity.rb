class Activity
  include Mongoid::Document
  field :name, type: String
  field :category, type: String
  field :location, type: String
  field :neighborhood, type: String
  field :link, type: String
  field :notes, type: String
  field :latitude, type: String
  field :longitude, type: String
  field :coordinates, type: Array

  

  belongs_to :user
  has_many :activity_categories

  include Geocoder::Model::Mongoid
	geocoded_by :location               # can also be an IP address
	after_validation :geocode 

	embeds_one :spot
end
