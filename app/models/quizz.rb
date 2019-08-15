class Quizz < ApplicationRecord
  belongs_to :type
  has_many :questions

end
