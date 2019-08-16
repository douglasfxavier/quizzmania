class Choice < ApplicationRecord
  belongs_to :tag
  has_many :answers
  
  accepts_nested_attributes_for :answers
end
