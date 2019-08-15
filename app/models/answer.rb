class Answer < ApplicationRecord
  belongs_to :choice
  belongs_to :question
  belongs_to :user

  accepts_nested_attributes_for :choice, :question
end
