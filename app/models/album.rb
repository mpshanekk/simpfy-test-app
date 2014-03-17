class Album < ActiveRecord::Base
    belongs_to :artist
	has_many :tracks
    
    mount_uploader :cover, AlbumUploader

	validates :title, :presence => true  

	def self.search(query)
      where("title like ?", "%#{query}%") 
    end
end
