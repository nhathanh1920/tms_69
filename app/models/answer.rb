class Answer < ApplicationRecord
  belongs_to :question
  has_many :exam_questions, through: :exam_answers
  has_many :exam_answers
end
