class Level < ApplicationRecord
  belongs_to :subject

  has_many :questions, dependent: :destroy
  validates :name, presence: true, length: {maximum: 50}
  validates :question_number, presence: true, numericality: {only_integer: true,
    greater_than_or_equal_to: 0, less_than: 100}
  scope :newest, ->{order created_at: :desc}

end
