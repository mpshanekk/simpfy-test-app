class Artist < ActiveRecord::Base
  has_many :albums
  has_many :tracks, :through => :albums

  GENDER = %w( Male Female )
  validates :name,   :presence => true
  validates :gender, :inclusion => {:in => GENDER}
end
