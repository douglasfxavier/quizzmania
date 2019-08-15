class Question < ApplicationRecord
  belongs_to :quizz
  has_many :answers, dependent: :destroy
  has_many :choices, dependent: :destroy

  accepts_nested_attributes_for :choices, reject_if: :all_blank, allow_destroy: true
end
