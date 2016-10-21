class Subject < ApplicationRecord
  has_many :questions
  has_many :exams
  has_many :suggest_questions

  validates :name, presence: true, length: {maximum: 50}
  validates :duration, presence: true, numericality: {only_integer: true}

  scope :newest, ->{order created_at: :desc}
end
