class Level < ApplicationRecord
  belongs_to :subject

  has_many :questions
  validates :question_number, presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: 0}
  scope :newest, ->{order created_at: :desc}

end
