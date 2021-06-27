class SupportCategory < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_many :support_threads, dependent: :destroy
  has_rich_text :description

  scope :sorted, ->{ order(position: :asc) }

  validates :name, :slug, :color, presence: true

  def color
    colour = super
    colour.start_with?("#") ? colour : "##{colour}"
  end
end
