class User < ApplicationRecord
  has_secure_password

  # set up required columns
  validates :username, :email, :first_name, :last_name, presence: true
  # set up unique columns
  validates :username, :email, uniqueness: true
  # set up min / max character lengths
  validates :first_name, :last_name, :email, :username, length: { minimum: 1, maximum: 100 }
  # set up email validation
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  # validate the username
  validate :validate_username
  validate :hello_user

  # associations
  has_many :posts, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :comments, dependent: :destroy # if user deletes their account, then delete their comments too
  has_one :location, as: :locationable, dependent: :destroy
  has_many :events

  # create the profile
  after_create :create_profile

  # events that the user has created
  has_many :created_events, class_name: "Event", foreign_key: "user_id"

  # events the user is participating in
  has_many :event_participants
  has_many :events, through: :event_participants

  private

  def hello_user
    puts "Hello, #{username} - #{email}"
  end

  def validate_username
    unless username =~ /\A[a-zA-Z0-9_]+\Z/
      errors.add(:username, "can only contain letters, numbers, and underscores, and must also contain one letter or number")
    end
  end
end
