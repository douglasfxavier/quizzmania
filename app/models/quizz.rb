class Quizz < ApplicationRecord
  belongs_to :type
  has_many :questions

  # accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
end
