class SupportPost < ApplicationRecord
  belongs_to :support_thread, counter_cache: true, touch: true
  belongs_to :user
  has_many :reactions, as: :reactable

  validates :user_id, :body, presence: true

  scope :sorted, ->{ order(:created_at) }

  after_update :solve_support_thread, if: :solved?

  def solve_support_thread
    support_thread.update(solved: true)
  end
end
