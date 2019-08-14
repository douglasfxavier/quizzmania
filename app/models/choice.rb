class Choice < ApplicationRecord
  belongs_to :choice
  has_many :answers
end
