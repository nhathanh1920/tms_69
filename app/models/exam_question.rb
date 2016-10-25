class ExamQuestion < ApplicationRecord
  belongs_to :exam
  belongs_to :question

  has_many :exam_answers
  has_many :answers, through: :exam_answers

  delegate :content, to: :question, allow_nil: :true
  delegate :content, to: :exam_answers, allow_nil: :true
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
  def check_correct
    if exam_answers.count == 0
      is_correct = false
    else
      if question.single_choice?
        is_correct = exam_answers.first.answer.is_correct
      elsif question.multi_choice?
        number_correct = question.answers
          .where(is_correct: true).count
        is_correct = exam_answers.joins(:answer)
          .where(answers: {is_correct: true}).count == number_correct
      else
        content_answer = exam_answers.first.content.downcase
        content = question.answers.first.content.downcase
        is_correct = content == content_answer
      end
    end
    self.update is_correct: is_correct
  end
end
