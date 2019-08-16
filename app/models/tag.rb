class Tag < ApplicationRecord
	has_many :choices
	belongs_to :quizz
	
end
