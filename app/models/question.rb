class Question < ApplicationRecord
  belongs_to :subject
  has_many :exam_questions
  has_many :answers

  enum status: {not_confirm: 0, confirmed: 1, rejected: 2}
  enum answer_type: {single_choice: 0, multi_choice: 1, text: 2}

  def set_default_status
    if user.admin?
      self.confirmed!
    else
      self.not_confirm!
    end
  end
end
