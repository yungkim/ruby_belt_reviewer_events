class User < ActiveRecord::Base
  has_many :events
  has_many :joins, dependent: :destroy
  has_many :events_joined, through: :joins, source: :event
  has_many :comments, dependent: :destroy
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :location, length: { in: 2..30 }
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }, length: { in: 8..20 }
  validates :state, presence: true
  validates_confirmation_of :password


  before_save do
    self.first_name.capitalize!
    self.last_name.capitalize!
    self.email.downcase!
    self.location.capitalize!
  end
end

