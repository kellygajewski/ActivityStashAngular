class Activity
  include Mongoid::Document
  include Geocoder::Model::Mongoid
  geocoded_by :location               # can also be an IP address
  after_validation :geocode 

  field :name, type: String
  field :location, type: String
  field :link, type: String
  field :notes, type: String
  field :latitude, type: String
  field :longitude, type: String
  field :coordinates, type: Array

  belongs_to :user
  has_many :activity_categories
	embeds_one :spot

  # First the objects
  def categories
    ActivityCategory.where(activity_id: id).map do |a|
      a.category
    end
  end

  # Show all related category IDs
  def category_ids
    categories.map(&:id)
  end

  # Add and remove categories from activities as necessary
  def category_ids=(vals)
    cat = ActivityCategory.where(activity_id: self.id).map(&:category_id)
    vals.each do |s|
      next if s.blank?
      s_id = BSON::ObjectId.from_string(s)
      if cat.include?(s_id)
        cat.delete(s_id)
      else
        ActivityCategory.create(activity_id: self.id, category_id: s_id)
      end
    end
    cat.each do |r|
      ActivityCategory.find_by(activity_id: self.id, category_id: r).destroy
    end
  end


end
