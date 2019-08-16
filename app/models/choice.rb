class Choice < ApplicationRecord
  has_many :answers
  belongs_to :tag

  accepts_nested_attributes_for :answers
end
