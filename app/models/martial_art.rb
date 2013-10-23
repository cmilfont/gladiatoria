class MartialArt < ActiveRecord::Base
	has_and_belongs_to_many :techniques
	validates_presence_of :name, :description
end
