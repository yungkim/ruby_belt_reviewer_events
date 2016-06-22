class Event < ActiveRecord::Base
  belongs_to :user
  has_many :joins, dependent: :destroy
  has_many :users_joined, through: :joins, source: :user
  has_many :comments, dependent: :destroy

  validates :name, :date, :state, presence: true
  validates :location, length: { in: 2..30 }
end
