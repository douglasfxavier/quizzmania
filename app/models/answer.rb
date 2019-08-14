class Answer < ApplicationRecord
  belongs_to :choice
  belongs_to :question
  has_one :user, dependent: :destroy

  accepts_nested_attributes_for :user
end
