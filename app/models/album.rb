class Album < ActiveRecord::Base
    belongs_to :artist
	has_many :tracks

	validates :title, :presence => true  
end
