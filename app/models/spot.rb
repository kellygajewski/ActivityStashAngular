class Spot
  include Mongoid::Document

 #  include Geocoder::Model::Mongoid
	# geocoded_by :address               # can also be an IP address
	# after_validation :geocode 

embedded_in :activity #inherits everything from activity model
end
