class Exam < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  has_many :exam_questions

  delegate :name, :to => :subject, :allow_nil => true

  enum status: {start: 0, testing: 1, uncheck: 2, checked: 3}

  before_create :create_exam_questions
  after_create :set_default

  accepts_nested_attributes_for :exam_questions

  scope :newest, ->{order created_at: :desc}

  def set_default
    self.start!
    self.update score: Settings.exams.default_score,
      spent_time: Settings.exams.default_spent_time
  end

  def update_status is_finished_or_checked = false
    if self.start?
      self.testing!
      self.update started_at: Time.now
    end
  end

  private
  def create_exam_questions
    level_ids = subject.levels.ids
    for i in 0...level_ids.length
      confirmed_questions = subject.levels[i].questions.order("RAND()")
        .limit subject.levels[i].question_number

      confirmed_questions.each do |question|
      self.exam_questions.build question_id: question.id,
        is_correct: Settings.exams.default_correct
    end
    end
  end
end
