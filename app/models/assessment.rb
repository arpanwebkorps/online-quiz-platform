class Assessment < ApplicationRecord
  has_many :questions
  has_many :coding_questions
  has_many :allocations
  has_many :users, through: :allocations

  validates :title, presence: true, length: {maximum:100}
  validates :duration_minutes, :total_mcqs_questions, presence: true, numericality: { only_integer: true }
  validate :duration_minutes_range

  private

  def duration_minutes_range
    if duration_minutes.present? && (duration_minutes < 10 || duration_minutes > 180)
      errors.add(:duration_minutes, "Assessment duration must be between 10 and 180 minutes")
    end
  end

end
