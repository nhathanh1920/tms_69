class Question < ApplicationRecord
  belongs_to :level

  has_many :exam_questions
  has_many :answers, dependent: :destroy

  enum status: {not_confirm: 0, confirmed: 1, rejected: 2}
  enum answer_type: {single_choice: 0, multi_choice: 1, text: 2}

  accepts_nested_attributes_for :answers, allow_destroy: true

  validates_associated :answers
  validate :validate_answers

  scope :newest, ->{order created_at: :desc}
  scope :random, ->(num){order("RAND()").limit num}

  def set_default_status
    if user.admin?
      self.confirmed!
    else
      self.not_confirm!
    end
  end

  private
  def validate_answers
    unless self.text?
      if answers.size <= Settings.minimum_answer
        errors.add :answers, I18n.t("questions.errors.must_more_one")
      end
      if answers.reject{|answer| !answer.is_correct?}.count == 0
        errors.add :answers, I18n.t("questions.errors.must_has_correct_answer")
      end
    end
  end
end
