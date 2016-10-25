class Exam < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  has_many :exam_questions

  delegate :name, to: :subject, allow_nil: :true

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
    elsif self.testing?
      if (get_remain_time < 0 || is_finished_or_checked)
        self.uncheck!
        calculate_score
        self.update score: exam_questions.count.where(is_correct: :true)
      end
      update_spent_time
    elsif self.uncheck? && is_finished_or_checked
      self.checked!
    end
  end

  def get_remain_time
     endtime = self.started_at + subject.duration.minutes
     seconds = endtime.to_i - Time.now.to_i
  end

  private
  def create_exam_questions
    level_ids = subject.levels.ids
    for i in 0...level_ids.length
      confirmed_questions = subject.levels[i].questions
        .random subject.levels[i].question_number
      confirmed_questions.each do |question|
      self.exam_questions.build question_id: question.id,
        content: question.content, is_correct: Settings.exams.default_correct
      end
    end
  end

  def update_spent_time
    start_time = self.started_at
    seconds = self.updated_at.to_i - start_time.to_i
    seconds = subject.duration.minutes if seconds > subject.duration.minutes
    self.update spent_time: seconds
  end

  def calculate_score
    count= 0
    exam_questions.each do |exam_question|
      exam_question.check_correct
    end
  end
end
