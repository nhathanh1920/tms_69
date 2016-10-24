class ExamQuestion < ApplicationRecord
  belongs_to :exam
  belongs_to :question

  has_many :exam_answers
  has_many :answers, through: :exam_answers


  delegate :content, to: :question, allow_nil: :true
  accepts_nested_attributes_for :exam_answers, allow_destroy: true

  def build_exam_answers
    if question.multi_choice?
      question.answers.each do |answer|
        unless self.answers.include? answer
          self.exam_answers.build answer_id: answer.id
        end
      end
    else
     self.exam_answers.build if self.exam_answers.empty?
    end
  end
end
