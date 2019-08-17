class Quizz < ApplicationRecord
  belongs_to :type
  has_many :questions
  has_many :tags

  accepts_nested_attributes_for :tags, reject_if: :all_blank, allow_destroy: true
end
