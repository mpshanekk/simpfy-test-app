class Track < ActiveRecord::Base
  belongs_to :album

  validates :name, :presence => true  
  validates :length, :numericality => true,  :allow_blank => true

  def self.search(query)
    where("name like ?", "%#{query}%") 
  end
end
